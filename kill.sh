#!/system/bin/sh
sync

am kill-all

echo ""
echo "----------------------------------------"
echo "★    SiFirmanyah Modz - Uninstall    ★"
echo "----------------------------------------"
echo ""

sleep 2

echo "Android Optimizer Priority 1.0 (MODZ)"
echo ""

sleep 2

kntl=$(pgrep -f bellavita.toast) >/dev/null 2>&1
if [ "$kntl" ]; then
  pkill -f "$kntl" > /dev/null 2>&1
fi

status=$(pgrep -f AOP) >/dev/null 2>&1
if [ "$status" ]; then
  pkill "$status" > /dev/null 2>&1
fi

status=$(pgrep -f AOP) >/dev/null 2>&1
if [ ! "$status" ]; then
  echo "Program failed to stop."
else
  echo "Program is stopped in the background."
fi
echo ""
rm -rf /data/local/tmp/AOP > /dev/null 2>&1
pm uninstall --user 0 bellavita.toast > /dev/null 2>&1
pm uninstall -k --user 0 bellavita.toast > /dev/null 2>&1
echo "Please reboot after kill this process"
echo ""

