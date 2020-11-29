#!/bin/sh

set -eu

if [ $# -ne 1 ]; then
	echo "Usage: $0 <INPUT_VIDEO>"
	exit 1
fi

INPUT_VIDEO=$1

NB_FRAMES=$(ffprobe -v quiet -i $INPUT_VIDEO -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -of default=noprint_wrappers=1:nokey=1)
DURATION=$(ffprobe -v quiet -i $INPUT_VIDEO -show_entries format=duration -of default=noprint_wrappers=1:nokey=1)

echo "scale=5; $NB_FRAMES / $DURATION" | bc

