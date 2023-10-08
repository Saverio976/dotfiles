# Right HDMI monitor
xrandr --output HDMI-1 --right-of eDP-1 --mode 1280x720

# Left Tablet monitor via adb
/opt/android-sdk/platform-tools/adb reverse tcp:3131 tcp:3131
xrandr --newmode "1280X720_tablet" 63.50 1280 1344 1472 1664  720 723 728 748 -hsync +vsync
xrandr --addmode DP-1 "1280X720_tablet"
xrandr --output DP-1 --mode "1280X720_tablet" --left-of eDP-1
deskscreen
