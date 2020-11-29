#!/bin/sh

set -eu

if [ $# -ne 2 ]; then
	echo "Usage: $0 <INPUT_VIDEO> <OUTPUT_FORMAT>"
	echo "   ex: $0 input.mp4 frames/%08d.png"
	exit 1
fi

INPUT_VIDEO=$1
OUTPUT_FORMAT=$2

mkdir -p $(dirname $OUTPUT_FORMAT)
ffmpeg -i $INPUT_VIDEO -vsync 0 -f image2 $OUTPUT_FORMAT
