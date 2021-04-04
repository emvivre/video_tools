#!/bin/sh

if [ $# -ne 1 ]; then
	echo "Usage: $0 <INPUT_VIDEO>"
	exit 1
fi

INPUT_VIDEO=$1
ffprobe -v quiet -show_entries stream=height -of default=noprint_wrappers=1:nokey=1 $INPUT_VIDEO

