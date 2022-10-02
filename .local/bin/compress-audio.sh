#!/bin/bash

TMP_FILE="tmp_audio_will_be_moved.ogg"
PARAMS1="-vf select=concatdec_select -af aselect=concatdec_select,aresample=async=1"
# PARAMS2="-safe 0 -f concat -segment_time_metadata 1"

if ! command -v ffmpeg &> /dev/null; then
    echo "install ffmpeg first"
    exit 84
fi
for FILE in $(/usr/bin/ls "$1"); do
    ffmpeg $PARAMS2 -i "$1/$FILE" -c:a libvorbis -qscale:a 1 $PARAMS1 "$1/$TMP_FILE" -y
    rm "$1/$FILE"
    mv "$1/$TMP_FILE" "$1/${FILE/.*$/.ogg}"
done
