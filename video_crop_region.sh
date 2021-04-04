#!/bin/sh

set -eu

align_4()
{
    read D
    echo $(expr $D - $D % 4)
}


if [ $# -ne 2 -a $# -ne 3 ]; then
    echo "Crop a region of interest defined dynamically by the user."
    echo "Usage: $0 [<WIDTH>:<HEIGHT>:<X>:<Y>] <INPUT_VIDEO> <OUTPUT_VIDEO>"
    echo "   ex: $0 input.mp4 output.mp4"
    echo "   ex: $0 504:284:839:223 input.mp4 output.mp4"
    exit 1
fi


if [ $# -eq 2 ]; then
    INPUT_VIDEO=$1
    OUTPUT_VIDEO=$2
    [ ! -f $INPUT_VIDEO  ] && echo 'ERROR: invalid input file given !' && exit 1

    # extraire one frame
    IMAGE=/tmp/out.png
    ffmpeg -y -i $INPUT_VIDEO -f image2 -vframes 1 $IMAGE

    # display image
    qiv $IMAGE &
    P=$!

    # get user region
    s=$(slop -f '%x %y %w %h')
    X=$(echo $s | awk '{print $1}')
    Y=$(echo $s | awk '{print $2}')
    WIDTH=$(echo $s | awk '{print $3}' | align_4)
    HEIGHT=$(echo $s | awk '{print $4}' | align_4)
    echo $X $Y $WIDTH $HEIGHT
    kill $P
    FORMAT=$WIDTH:$HEIGHT:$X:$Y
else
    FORMAT=$1
    INPUT_VIDEO=$2
    OUTPUT_VIDEO=$3
    [ ! -f $INPUT_VIDEO ] && echo 'ERROR: invalid input file given !' && exit 1
    echo $1 | grep -E '^[0-9]+:[0-9]+:[0-9]+:[0-9]+$' || (echo 'ERROR: invalid input format given. Please use <WIDTH>:<HEIGHT>:<X>:<Y> format.' && exit 1)
fi

# extract video
ffmpeg -y -i $INPUT_VIDEO -vf crop=$FORMAT $OUTPUT_VIDEO
