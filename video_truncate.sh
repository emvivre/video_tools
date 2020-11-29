#!/bin/sh

set -eu

if [ $# -ne 4 ];then
	echo "Usage: $0 <INPUT_VIDEO> <TIME_BEG> <TIME_END> <OUTPUT_VIDEO>"
	exit 1
fi

INPUT_VIDEO=$1
TIME_BEG=$2
TIME_END=$3
OUTPUT_VIDEO=$4

ffmpeg -y -i $INPUT_VIDEO -ss $TIME_BEG -to $TIME_END -c copy $OUTPUT_VIDEO

