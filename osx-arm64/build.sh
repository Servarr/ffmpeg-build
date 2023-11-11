#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"

brew install automake shtool nasm dylibbundler

# The arm64 version of dav1d to link against
response=$(brew fetch --force --bottle-tag=arm64_big_sur dav1d | grep "Downloaded to")
parsed=${response#Downloaded to: }
brew install -v "$parsed"

rm -rf "${SCRIPT_DIR}"/libbluray
mkdir -p "${SCRIPT_DIR}"/libbluray
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj -C "${SCRIPT_DIR}/libbluray" --strip-components=1
pushd "${SCRIPT_DIR}"/libbluray
CFLAGS="-arch arm64 -mmacosx-version-min=11.0" LDFLAGS="-arch arm64" ./configure --host=aarch64-apple-darwin prefix="${SCRIPT_DIR}/build" --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-libxml2 --without-freetype --without-fontconfig
make
make install
popd

mkdir -p "${SCRIPT_DIR}/output" "${SCRIPT_DIR}/build"

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

${SOURCE_DIR}/compile.sh $SCRIPT_DIR

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"
