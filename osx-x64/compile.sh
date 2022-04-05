#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

source common.sh

export MACOSX_DEPLOYMENT_TARGET=10.13

FFMPEG_CONFIGURE_FLAGS+=(
    --cc=clang
)

ARGS=("${NATIVE_DIR_FLAGS[@]}" "${FFMPEG_CONFIGURE_FLAGS[@]}")
./configure "${ARGS[@]}"
    
make -j6
make install

otool -l ${OUT_DIR}/output/ffprobe
otool -L ${OUT_DIR}/output/ffprobe
file ${OUT_DIR}/output/ffprobe

dylibbundler -b -x ${OUT_DIR}/output/ffprobe -d ${OUT_DIR}/output -p @executable_path

ls -lh ${OUT_DIR}/output
otool -L ${OUT_DIR}/output/ffprobe

wget -q 'http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/Chimera/Chimera-2397fps-AV1-10bit-960x540-1658kbps.obu'
${OUT_DIR}/output/ffprobe -print_format json -show_format -show_streams Chimera-2397fps-AV1-10bit-960x540-1658kbps.obu

popd
