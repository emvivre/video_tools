#!/bin/sh

set -eu

if [ $# -ne 3 ]; then
	echo "Usage: $0 <TIME> <INPUT_VIDEO> <OUTPUT_IMAGE>"
	echo "   ex: $0 01:30 input.mkv output.png"
	exit 1
fi

TIME=$1
INPUT_VIDEO=$2
OUTPUT_IMAGE=$3

ffmpeg -y -ss $TIME -i $INPUT_VIDEO -f image2 -vframes 1 $OUTPUT_IMAGE


