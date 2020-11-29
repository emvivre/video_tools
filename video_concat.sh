#!/bin/sh

set -eu

if [ $# -lt 3 ]; then
    echo "Usage: $0 <INTPUT_VIDEO_0> <INPUT_VIDEO_1> ... <OUTPUT_VIDEO>"
    exit 1
fi

LIST=$(mktemp -p .)
echo --- $LIST
for i in $(seq 2 $#); do
    f=$1
    echo "file '$f'" >> $LIST
    shift
done
OUTPUT_VIDEO=$1

ffmpeg -y -f concat -i $LIST -c copy $OUTPUT_VIDEO
unlink $LIST
