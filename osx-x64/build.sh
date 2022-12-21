#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../ffmpeg"

brew install automake shtool nasm dav1d dylibbundler

mkdir -p "${SCRIPT_DIR}/output" "${SCRIPT_DIR}/build"

brew cat libbluray > "${SCRIPT_DIR}/build/libbluray.rb"
sed -i '' -e 's/%W\[/&--without-fontconfig --without-freetype /; s/depends_on "fontconfig"/#&/; s/depends_on "freetype"/#&/' "${SCRIPT_DIR}/build/libbluray.rb"
brew reinstall --build-from-source "${SCRIPT_DIR}/build/libbluray.rb"

cp "${SCRIPT_DIR}/../common.sh" "${SOURCE_DIR}"
cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

${SOURCE_DIR}/compile.sh $SCRIPT_DIR

rm "${SOURCE_DIR}/compile.sh"
rm "${SOURCE_DIR}/common.sh"
