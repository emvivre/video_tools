#!/bin/bash

set -eu

if [ $# -ne 4 ]; then
    echo "Usage: $0 <INPUT_VIDEO> <SECOND_DURATION> <NB_PART> <OUTPUT_PREFIX>"
    exit 1
fi

INPUT_VIDEO=$1
SECOND_DURATION=$2
NB_PART=$3
OUTPUT_PREFIX=$4

EXT=${INPUT_VIDEO##*.}

for i in $(seq $NB_PART); do
    S=$(echo "($i-1)*$SECOND_DURATION" | bc)
    OUT="${OUTPUT_PREFIX}_${i}.${EXT}"
    ffmpeg -y -i $INPUT_VIDEO -ss $S -t $SECOND_DURATION $OUT
done
