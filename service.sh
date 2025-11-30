#!/system/bin/sh
# zapret-magisk service script

# Wait for boot to finish/network to initialize
sleep 10

# Log file location
LOGFILE="/data/adb/zapret/service.log"

echo "[$(date)] Service started" > "$LOGFILE"

if [ -f /data/adb/zapret/autostart ]; then
    echo "[$(date)] Autostart flag found. Starting zapret..." >> "$LOGFILE"
    if [ -x /system/bin/zapret ]; then
        /system/bin/zapret start >> "$LOGFILE" 2>&1
    else
        echo "[$(date)] Error: /system/bin/zapret not executable or not found" >> "$LOGFILE"
    fi
else
    echo "[$(date)] Autostart flag NOT found. Skipping." >> "$LOGFILE"
fi
