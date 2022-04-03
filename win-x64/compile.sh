#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --enable-cross-compile
    --arch=x86_64
    --target-os=mingw32
    --cross-prefix=x86_64-w64-mingw32-
    --disable-d3d11va
    --disable-dxva2
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
)

./configure "${FFMPEG_CONFIGURE_FLAGS[@]}"

make -j6
make install

popd
