#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"

brew install automake shtool nasm dav1d dylibbundler

mkdir -p "${SCRIPT_DIR}/output" "${SCRIPT_DIR}/build"

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

${SOURCE_DIR}/compile.sh $SCRIPT_DIR

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"
