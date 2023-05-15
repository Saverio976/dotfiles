#!/bin/bash
# download online audio with url

ECHO_HELP=0
if [ "$1" == "-h" ]
then
    ECHO_HELP=1
fi
if [ "$1" == "--help" ]
then
    ECHO_HELP=1
fi
if [ "$1" == "" ]
then
    ECHO_HELP=1
fi

if [ $ECHO_HELP -eq 1 ]
then
    echo "USAGE:"
    echo "bash audio-download.sh URL [directory_path [ogg]]"
    echo
    echo "download online audio with URL, example:"
    echo "bash audio-download.sh https://www.youtube.com/watch?v=f_zpcGKgXgw"
    echo
    echo "if you provide a directory path, it will download file here,"
    echo "else it will download to the current working directory, example:"
    echo "bash audio-download.sh https://www.youtube.com/watch?v=f_zpcGKgXgw something/"
    echo
    echo "and if you want to download the video using ogg format,"
    echo "please provide a path and write ogg after, example:"
    echo "bash audio-download.sh https://www.youtube.com/watch?v=f_zpcGKgXgw . ogg"
    echo
    echo "To pass extra args to youtube-dl:"
    echo "Set the YTDL_EXTRA_ARGS env variable to the extra args to pass"
    exit 0
fi

if ! command -v yt-dlp &> /dev/null
then
    echo "you need to install 'yt-dlp' package"
    exit 84
fi

if [ "$2" == "" ]
then
    DIR_PATH='.'
else
    DIR_PATH=$2
fi

if [ "$3" == "ogg" ]
then
    OGG_COMMAND='--recode-video ogg'
else
    OGG_COMMAND=''
fi

echo "download audio"
yt-dlp \
    --ignore-config \
    --geo-bypass \
    --yes-playlist \
    --restrict-filenames \
    --no-cache-dir \
    --format 'bestaudio[ext=mp3]/bestaudio' \
    $1 \
    -o "$DIR_PATH/%(title)s.%(ext)s" \
    $OGG_COMMAND \
    --ignore-errors \
    $YTDL_EXTRA_ARGS
