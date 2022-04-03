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
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
)

./configure "${FFMPEG_CONFIGURE_FLAGS[@]}"

make -j6
make install

popd
