#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

./configure \
    --prefix="${OUT_DIR}/build" \
    --bindir="${OUT_DIR}/output" \
    --disable-shared \
    --enable-static \
    --disable-ffplay \
    --disable-ffmpeg \
    --disable-encoders \
    --disable-filters \
    --disable-devices \
    --disable-muxers \
    --disable-protocols \
    --enable-protocol=file \
    --disable-bsfs \
    --disable-network \
    --disable-doc \
    --disable-audiotoolbox \
    --disable-videotoolbox
    
make -j6
make install

otool -L ${OUT_DIR}/output/ffprobe

popd
