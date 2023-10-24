# dotfiles

## Bindings (i3wm)

$mod = Meta

```bash
$mod+Return = open kitty terminal
$mod+n = dropdown kitty (need https://pypi.org/project/kitti3/)

$mod+Shift+q = kill current window

$mod+d = dmenu like (rofi)

$mod+Left = focus window left
$mod+Right = focus window right
$mod+Up = focus window up
$mod+Down = focus window down

$mod+Shift+Left = move window left
$mod+Shift+Down = move window down
$mod+Shift+Up = move window up
$mod+Shift+Right = move window right

$mod+h = split next window in horizontal orientation
$mod+v = split next window in vertical orientation

$mod+s = change layout to stacking
$mod+w = change layout to tabbed
$mod+e = toggle splited layout

$mod+f = fullscreen toggle

$mod+Shift+space = toggle floating window
$mod+space = toggle focus on floating window/ tiling window

$mod+a = select parent container (parent of window layout)

$mod+1 = workspace 1
...
$mod+9 = workspace 9

$mod+Shift+1 = move window to workspace 1
...
$mod+Shift+9 = move window to workspace 9

$mod+Shift+c = reload config file
$mod+Shift+r = restart i3 inplace
$mod+Shift+e = exit xsession

$mod+r = enter window resize mode
- $mod+Left = grow window to left
- $mod+Right = grow window to right
- $mod+Up = grow window to up
- $mod+Down = grow window to down
- $mod+r = exit resize mode

$Control+Shift+e = enable autolock (enabled by default)
$Control+Shift+d = disable autolock

Print = worspace screenshot to /home/$USER/Pictures/$(date).png
$mod+Print = window screenshot to /home/$user/pictures/$(date).png
Shift+Print = select what to screenshot to /home/$user/pictures/$(date).png

Control+Print = worspace screenshot to clipboard
Control+$mod+Print = window screenshot to clipboard
Control+Shift+Print = select what to screenshot to clipboard
```

## Background (feh)

choose random image in `$HOME/.local/share/wallpaper/`

# INSTALL

## Install yadm
- use [yadm](https://yadm.io/)

- run
```bash
# yadm clone https://github.com/Saverio976/dotfiles.git
yadm clone https://git.kreog.com/Saverio976/dotfiles.git
```
## Via bash
```bash
curl -fLo /tmp/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && \
    chmod a+x /tmp/yadm && \
    /tmp/yadm clone https://github.com/Saverio976/dotfiles.git
```

## REMAINDER

## pactl

### set output audio to hdmi
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo

### set output audio to pc
pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo

## xrandr

### set second screen
xrandr --output HDMI-1-1 --mode 1920x1080 --right-of eDP1

### remove the second screen set
xrandr --auto

## gpg

### export key to file
gpg --export-secret-key KEY_ID > file

### import gpg
gpg --import file

## Fonts

### re cache all fonts
fc-cache -f -v

## Bash

### parameter substitution
[wiki-bash](https://wiki.bash-hackers.org/syntax/pe)

## device

### lsblk
lsblk

### lsscsi
lsscsi

## Nvidia

### envycontrol
envycontrol --switch {hybrid,nvidia,integrated}

## Arch Package

- ananicy-cpp
- gcc
- fd
- ripgrep
- make
- cmake
- unzip
- git
- neovim
- kitty
- i3lock
- i3status
- rofi
- maim
- paru
- podman
- podman-docker
- proton-ge-custom-bin
- thermald
- power-profiles-daemon
- python
- python-pip
- shellcheck-bin
- wine
- winetricks
- profile-sync-daemon
- anything-sync-daemon
- heroic-games-launcher-bin
