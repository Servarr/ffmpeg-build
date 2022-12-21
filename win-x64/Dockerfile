FROM ubuntu:20.04

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apt-get update && apt-get install -y \
    gcc-mingw-w64 \
    autoconf \
    automake \
    build-essential \
    cmake \
    git-core \
    libtool \
    meson \
    ninja-build \
    pkg-config \
    wget \
    yasm \
    zlib1g-dev \
    nasm

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build

RUN git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git /dav1d && \
mkdir -p /dav1d/build && \
cd /dav1d/build && \
meson setup -Denable_tools=false -Denable_tests=false --default-library=static --prefix=/usr/x86_64-w64-mingw32 --libdir=/usr/x86_64-w64-mingw32/lib --cross-file=../package/crossfiles/x86_64-w64-mingw32.meson .. && \
ninja && \
ninja install

RUN mkdir /zlib && \
wget -qO- https://zlib.net/zlib-1.2.13.tar.gz | tar xz --strip-components=1 -C /zlib && \
cd /zlib && \
CHOST=x86_64-w64-mingw32 ./configure --prefix=/usr/x86_64-w64-mingw32 --static && \
make && \
make install

RUN mkdir /libxml2 && \
wget -qO- https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.1.tar.xz | tar xJ --strip-components=1 -C /libxml2 && \
cd /libxml2 && \
./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 --disable-shared --disable-dependency-tracking --disable-silent-rules --without-python && \
make && \
make install

RUN mkdir /libbluray && \
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj --strip-components=1 -C /libbluray && \
cd /libbluray && \
PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/lib/pkgconfig ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-freetype --without-fontconfig && \
make && \
make install
