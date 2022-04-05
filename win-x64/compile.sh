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
    --pkg-config=pkg-config
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
)

ARGS=("${DOCKER_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/lib/pkgconfig ./configure "${ARGS[@]}"

make -j6
make install

popd
