#!/bin/sh

set -eu

if [ $# -ne 2 ]; then
	echo "Usage: $0 <INPUT_VIDEO> <OUTPUT_VIDEO>"
	exit 1
fi

INPUT_VIDEO=$1
OUTPUT_VIDEO=$2
ffmpeg -y -i $INPUT_VIDEO -filter_complex '[0:v]setpts=PTS-STARTPTS[v0];[v0]concat=n=1:v=1:a=0[v]' -map '[v]' $OUTPUT_VIDEO

