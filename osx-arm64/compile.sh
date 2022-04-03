#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

source common.sh

export MACOSX_DEPLOYMENT_TARGET=11.0

FFMPEG_CONFIGURE_FLAGS+=(
    --cc=clang
    --enable-cross-compile
    --arch=arm64
    --disable-asm
    --disable-shared
    --enable-static
    --disable-lzma
    --disable-audiotoolbox
    --disable-videotoolbox
)

CFLAGS="-arch arm64" LDFLAGS="-arch arm64" ./configure "${FFMPEG_CONFIGURE_FLAGS[@]}"

make -j6
make install

otool -l ${OUT_DIR}/output/ffprobe
otool -L ${OUT_DIR}/output/ffprobe
file ${OUT_DIR}/output/ffprobe

popd
