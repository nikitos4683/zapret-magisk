#!/system/bin/sh

ui_print "Copying nfqws for $ARCH"
case "$ARCH" in
    arm64)   cp -af "$MODPATH/common/nfqws_arm64" "$MODPATH/system/bin/nfqws";;
    arm)     cp -af "$MODPATH/common/nfqws_arm" "$MODPATH/system/bin/nfqws";;
    x86)     cp -af "$MODPATH/common/nfqws_x86" "$MODPATH/system/bin/nfqws";;
    x64)     cp -af "$MODPATH/common/nfqws_x64" "$MODPATH/system/bin/nfqws";;
esac

# Ensure binaries are executable
chmod 755 "$MODPATH/system/bin/nfqws"
chmod 755 "$MODPATH/system/bin/zapret"
chmod 755 "$MODPATH/system/bin/zapret_check.sh"

if ! [ -d "/data/adb/zapret" ]; then
    ui_print "Creating directory for zapret";
    mkdir -p "/data/adb/zapret";
fi;

ui_print "Setting up config files..."

# Helper to copy config only if it doesn't exist
copy_if_missing() {
    if [ ! -f "$2" ]; then
        ui_print "Creating $2"
        cat "$1" > "$2"
        chmod 666 "$2"
    else
        ui_print "Skipping $2 (already exists)"
    fi
}

copy_if_missing "$MODPATH/common/autohosts.txt" "/data/adb/zapret/autohosts.txt"
copy_if_missing "$MODPATH/common/ignore.txt" "/data/adb/zapret/ignore.txt"
copy_if_missing "$MODPATH/common/config.txt" "/data/adb/zapret/config.txt"

# Cleanup common folder from module dir
rm -rf "$MODPATH/common"

# Enable autostart by default if not explicitly disabled?
# Or just ensure the file exists only on first install?
# Current logic: always enable autostart on install/update.
if [ ! -f "/data/adb/zapret/autostart" ]; then
    touch "/data/adb/zapret/autostart"
fi

ui_print "Read the guide at https://wiki.malw.link/network/vpns/zapret"
