#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --enable-static
    --disable-shared
    --pkg-config-flags="--static"
    --extra-libs="-static -L/usr/lib"
    --extra-cflags="--static"
    --cc=/usr/bin/clang
    --cxx=/usr/bin/clang-cpp
)

./configure "${FFMPEG_CONFIGURE_FLAGS[@]}"

gmake -j6
gmake install

ldd ${OUT_DIR}/output/ffprobe || true

popd
