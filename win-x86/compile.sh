#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --enable-cross-compile
    --arch=i686
    --target-os=mingw32
    --cross-prefix=i686-w64-mingw32-
    --pkg-config=pkg-config
    --disable-d3d11va
    --disable-dxva2
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
)

ARGS=("${DOCKER_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
PKG_CONFIG_PATH=/usr/i686-w64-mingw32/lib/pkgconfig ./configure "${ARGS[@]}"

make -j6
make install

popd
