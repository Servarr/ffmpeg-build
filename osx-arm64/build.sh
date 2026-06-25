#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"

brew install meson nasm dylibbundler

rm -rf "${SCRIPT_DIR}"/libbluray
mkdir -p "${SCRIPT_DIR}"/libbluray
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj -C "${SCRIPT_DIR}/libbluray" --strip-components=1
pushd "${SCRIPT_DIR}"/libbluray
CFLAGS="-arch arm64 -mmacosx-version-min=11.0" LDFLAGS="-arch arm64" ./configure --host=aarch64-apple-darwin prefix="${SCRIPT_DIR}/build" --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-libxml2 --without-freetype --without-fontconfig
make
make install
popd

mkdir -p "${SCRIPT_DIR}/output" "${SCRIPT_DIR}/build"

rm -rf "${SCRIPT_DIR}/build/dav1d"
git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git "${SCRIPT_DIR}/build/dav1d" && \
mkdir -p "${SCRIPT_DIR}/build/dav1d/build" && \
cd "${SCRIPT_DIR}/build/dav1d/build" && \
meson setup -Denable_tools=false -Denable_tests=false --default-library=static --prefix="${SCRIPT_DIR}/build/dav1d-prefix" --libdir=lib --cross-file="${SCRIPT_DIR}/aarch64-apple-darwin.meson" .. && \
ninja && \
ninja install

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"
export PKG_CONFIG_PATH="${SCRIPT_DIR}/build/dav1d-prefix/lib/pkgconfig:${PKG_CONFIG_PATH:-}"

"${SOURCE_DIR}/compile.sh" "${SCRIPT_DIR}"

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"