#!/system/bin/sh
sync

am kill-all

echo ""
echo "------------------------------------"
echo "★    SiFirmanyah Modz - Module    ★"
echo "------------------------------------"
echo ""

sleep 2

echo "Android Optimizer Priority 1.0 (MODZ)"
echo ""

sleep 2

status=$(ls /sdcard/Android-Optimizer-Priority/Toast.apk) >/dev/null 2>&1
if [ "$status" ]; then
    pm install /sdcard/Android-Optimizer-Priority/Toast.apk > /dev/null 2>&1
    cp /sdcard/Android-Optimizer-Priority/Toast.apk /data/local/tmp/ > /dev/null >&1
    pm install /data/local/tmp/Toast.apk > /dev/null 2>&1
else
    am kill-all > /dev/null 2>&1
fi

sleep 2

status=$(pgrep -f AOP) >/dev/null 2>&1
if [ ! "$status" ]; then
    cp /sdcard/Android-Optimizer-Priority/bin/AOP /data/local/tmp
    chmod +x /data/local/tmp/AOP
    nohup /data/local/tmp/AOP > /dev/null 2>&1 &
fi

sleep 2

#What are you looking at, you are gay??
status=$(pgrep -f AOP) >/dev/null 2>&1
if [ "$status" ]; then
    echo "Succcesful program is running"
    echo "$(am start -a android.intent.action.MAIN -e toasttext "Program is running in the background." -n bellavita.toast/.MainActivity)" > /dev/null 2>&1
    sleep 10
    pm uninstall --user 0 bellavita.toast > /dev/null 2>&1
    pm uninstall -k --user 0 bellavita.toast > /dev/null 2>&1
else
    echo "Failed to run"
    echo "$(am start -a android.intent.action.MAIN -e toasttext "Program failed to run" -n bellavita.toast/.MainActivity)" > /dev/null 2>&1
    sleep 10
    pm uninstall --user 0 bellavita.toast > /dev/null 2>&1
    pm uninstall -k --user 0 bellavita.toast > /dev/null 2>&1
fi
echo ""
