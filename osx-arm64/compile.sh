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
    --disable-autodetect
    --enable-appkit
    --enable-avfoundation
    --enable-coreimage
    --enable-metal
    --enable-zlib
)

ARGS=("${NATIVE_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
CFLAGS="-arch arm64" LDFLAGS="-arch arm64" ./configure "${ARGS[@]}"

make -j6
make install

otool -l ${OUT_DIR}/output/ffprobe
otool -L ${OUT_DIR}/output/ffprobe
file ${OUT_DIR}/output/ffprobe

dylibbundler -b -x ${OUT_DIR}/output/ffprobe -d ${OUT_DIR}/output -p @executable_path

ls -lh ${OUT_DIR}/output
otool -L ${OUT_DIR}/output/ffprobe

popd
