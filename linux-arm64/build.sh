#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"
OUT_DIR="${SCRIPT_DIR}/output"

mkdir -p $OUT_DIR

docker build -t ffmpeg-linux-arm64 - < ${SCRIPT_DIR}/Dockerfile

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

docker run --rm -v "${SOURCE_DIR}:/ffmpeg/sources" -v "${OUT_DIR}:/ffmpeg/bin" ffmpeg-linux-arm64 /ffmpeg/sources/compile.sh

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"
