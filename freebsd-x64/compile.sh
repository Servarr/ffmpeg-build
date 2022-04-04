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

ARGS=("${NATIVE_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
./configure "${ARGS[@]}"

gmake -j6
gmake install

ldd ${OUT_DIR}/output/ffprobe || true

wget -q 'http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/Chimera/Chimera-2397fps-AV1-10bit-960x540-1658kbps.obu'
${OUT_DIR}/output/ffprobe -print_format json -show_format -show_streams Chimera-2397fps-AV1-10bit-960x540-1658kbps.obu

popd
