#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --enable-cross-compile
    --arch=aarch64
    --target-os=linux
    --cross-prefix=aarch64-linux-gnu-
    --pkg-config=pkg-config
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
)

ARGS=("${DOCKER_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
PKG_CONFIG_PATH=/usr/aarch64-linux-gnu/lib/pkgconfig ./configure "${ARGS[@]}"

make -j6
make install

popd
