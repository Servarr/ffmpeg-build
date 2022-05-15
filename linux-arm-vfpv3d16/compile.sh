#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --enable-cross-compile
    --arch=armhf
    --target-os=linux
    --cross-prefix=arm-linux-gnueabihf-
    --pkg-config=pkg-config
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
    --extra-cflags="-mfpu=vfpv3-d16"
    --extra-cxxflags="-mfpu=vfpv3-d16"
)

ARGS=("${DOCKER_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
PKG_CONFIG_PATH=/usr/arm-linux-gnueabihf/lib/pkgconfig ./configure "${ARGS[@]}"

make -j6
make install

popd
