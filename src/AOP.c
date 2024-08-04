#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <dirent.h>

void setPriorities(const char *cmd) {
    char chrt_command[128];
    char tasksetff_command[128];
    char taskset0f_command[128];
    char tasksetf0_command[128];
    char trim_command[128];
    char clearsystem_command[128];
    char clearandroid_command[128];

    snprintf(chrt_command, sizeof(chrt_command), "chrt -f -p 99 %s > /dev/null 2>&1", cmd);
    snprintf(tasksetff_command, sizeof(tasksetff_command), "taskset -p ff %s > /dev/null 2>&1", cmd);
    snprintf(taskset0f_command, sizeof(taskset0f_command), "taskset -p 0f %s > /dev/null 2>&1", cmd);
    snprintf(tasksetf0_command, sizeof(tasksetf0_command), "taskset -p f0 %s > /dev/null 2>&1", cmd);
    snprintf(trim_command, sizeof(trim_command), "pm trim-caches 999999999999999999 %s > /dev/null 2>&1", cmd);
    snprintf(clearsystem_command, sizeof(clearsystem_command), "am clear-exit-info --user %s com.android.systemui > /dev/null 2>&1", cmd);
    snprintf(clearandroid_command, sizeof(clearandroid_command), "am clear-exit-info --user %s android > /dev/null 2>&1", cmd);

    system(chrt_command);
    system(tasksetff_command);
    system(taskset0f_command);
    system(tasksetf0_command);
    system(trim_command);
    system(clearsystem_command);
    system(clearandroid_command);
    system("pm trim-caches 999999999999999999 0");
    system("am kill-all");
    system("pm trim-caches 999999999999999999 internal");
}

#define MAX_COMMAND_LEN 512
#define MAX_CMD_LEN 64

int main() {

    int null_fd = open("/dev/null", O_WRONLY);
    dup2(null_fd, STDOUT_FILENO);
    dup2(null_fd, STDERR_FILENO);
    close(null_fd);

    char app[MAX_COMMAND_LEN];
    char cmd[MAX_CMD_LEN];
    FILE *fp;

    while (1) {
      system("clear");
      sleep(5);
            if (fgets(app, sizeof(app), fp) != NULL) {
                app[strcspn(app, "\n")] = 0;
                if (strlen(app) > 0) {
                    snprintf(cmd, sizeof(cmd), "pgrep -E -w '^android^' && pidof -s com.android.systemui");
                    FILE *cmd_fp = popen(cmd, "r");
                    if (cmd_fp != NULL) {
                        char cmd_buffer[MAX_CMD_LEN];
                        while (fgets(cmd_buffer, sizeof(cmd_buffer), cmd_fp) != NULL) {
                            cmd_buffer[strcspn(cmd_buffer, "\n")] = 0;
                            setPriorities(cmd_buffer);
                        }
                        pclose(cmd_fp);
                    }
                }
            }
            pclose(fp);
        }
        sleep(5);
    return 0;
}
