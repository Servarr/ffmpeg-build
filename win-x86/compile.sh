#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

./configure \
    --prefix="/ffmpeg/build" \
    --bindir="/ffmpeg/bin" \
    --enable-cross-compile \
    --arch=i686 \
    --target-os=mingw32 \
    --cross-prefix=i686-w64-mingw32- \
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
    --disable-doc \
    --pkg-config-flags="--static" \
    --extra-ldexeflags="-static" \
    --extra-libs="-lpthread -lm"

make -j6
make install

popd