#!/bin/sh

set -eu

if [ $# -ne 3 ]; then
	echo "Usage: $0 <FRAME_RATE> <INPUT_FORMAT> <OUTPUT_VIDEO>"
	echo "   ex: $0 30 frames/%08d.png out.mp4"
	exit 1
fi

FRAME_RATE=$1
INPUT_FORMAT=$2
OUTPUT_VIDEO=$3

ffmpeg -y -f image2 -r $FRAME_RATE -i $INPUT_FORMAT -c copy $OUTPUT_VIDEO

