#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --pkg-config-flags="--static"
    --extra-ldexeflags="-static"
    --extra-libs="-lpthread -lm"
)

ARGS=("${DOCKER_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
./configure "${ARGS[@]}"

make -j6
make install

popd
