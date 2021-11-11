#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

export MACOSX_DEPLOYMENT_TARGET=11.0

CFLAGS="-arch arm64" LDFLAGS="-arch arm64" ./configure \
    --cc=clang \
    --enable-cross-compile \
    --arch=arm64 \
    --disable-asm \
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

otool -l ${OUT_DIR}/output/ffprobe
otool -L ${OUT_DIR}/output/ffprobe
file ${OUT_DIR}/output/ffprobe

popd
