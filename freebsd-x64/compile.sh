#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

./configure \
    --prefix="${OUT_DIR}/build" \
    --bindir="${OUT_DIR}/output" \
    --enable-static \
    --disable-shared \
    --pkg-config-flags="--static" \
    --extra-libs="-static -L/usr/lib" \
    --extra-cflags="--static" \
    --cc=/usr/bin/clang \
    --cxx=/usr/bin/clang-cpp \
    --disable-ffplay \
    --disable-ffmpeg \
    --disable-encoders \
    --disable-filters \
    --disable-devices \
    --disable-muxers \
    --disable-protocols \
    --enable-protocol=file \
    --disable-bsfs \
    --disable-network \
    --disable-doc

gmake -j6
gmake install

ldd ${OUT_DIR}/output/ffprobe || true

popd
