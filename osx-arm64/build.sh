#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"

brew install automake shtool nasm dylibbundler

# The arm64 version of dav1d to link against
response=$(brew fetch --force --bottle-tag=arm64_big_sur dav1d | grep "Downloaded to")
parsed=${response#Downloaded to: }
brew install -v "$parsed"

mkdir -p "${SCRIPT_DIR}/output" "${SCRIPT_DIR}/build"

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

${SOURCE_DIR}/compile.sh $SCRIPT_DIR

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"
