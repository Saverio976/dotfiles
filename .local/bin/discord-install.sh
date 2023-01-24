#!/bin/bash
# Download discord source and Install from terminal

set -x
cd /opt/
touch .test.test
if [ "$?" != 0 ] && [ "$EUID" != 0 ]; then
    sudo -- "$0" "$@"
    rm -f .test.test
    exit
fi
rm -f .test.test
curl -L -o ./Discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
tar xf ./Discord.tar.gz
echo "[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Discord
Comment=Discord application
Exec=/opt/Discord/Discord
Icon=/opt/Discord/discord.png
Terminal=false
Path=/opt/Discord" > /usr/share/applications/Discord.desktop
# prompt a good indicator
echo "Succesfull installation"
set +x
