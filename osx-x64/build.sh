#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"

brew install automake shtool nasm dav1d dylibbundler

mkdir -p "${SCRIPT_DIR}/output" "${SCRIPT_DIR}/build"

rm -rf "${SCRIPT_DIR}"/libbluray
mkdir -p "${SCRIPT_DIR}"/libbluray
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj -C "${SCRIPT_DIR}/libbluray" --strip-components=1
pushd "${SCRIPT_DIR}"/libbluray
CFLAGS="-mmacosx-version-min=10.13" ./configure --prefix="${SCRIPT_DIR}/build" --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-libxml2 --without-freetype --without-fontconfig
make
make install
popd

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

${SOURCE_DIR}/compile.sh $SCRIPT_DIR

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"
