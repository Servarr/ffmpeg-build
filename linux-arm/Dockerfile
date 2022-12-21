FROM ubuntu:20.04

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apt-get update && apt-get install -y \
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
    nasm \
    gcc-arm-linux-gnueabihf

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build

COPY root/ /

RUN git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git /dav1d && \
mkdir -p /dav1d/build && \
cd /dav1d/build && \
meson setup -Denable_tools=false -Denable_tests=false --default-library=static --prefix=/usr/arm-linux-gnueabihf --libdir=/usr/arm-linux-gnueabihf/lib --cross-file=/root/armhf.txt -- .. && \
ninja && \
ninja install

RUN mkdir /zlib && \
wget -qO- https://zlib.net/zlib-1.2.13.tar.gz | tar xz --strip-components=1 -C /zlib && \
cd /zlib && \
CHOST=arm-linux-gnueabihf ./configure --prefix=/usr/arm-linux-gnueabihf --static && \
make && \
make install

RUN mkdir /libxml2 && \
wget -qO- https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.1.tar.xz | tar xJ --strip-components=1 -C /libxml2 && \
cd /libxml2 && \
./configure --host=arm-linux-gnueabihf --prefix=/usr/arm-linux-gnueabihf --disable-shared --disable-dependency-tracking --disable-silent-rules --without-python && \
make && \
make install

RUN git clone --depth 1 --recurse-submodules --branch 1.3.4 https://code.videolan.org/videolan/libbluray.git /libbluray && \
cd /libbluray && \
./bootstrap && \
PKG_CONFIG_PATH=/usr/arm-linux-gnueabihf/lib/pkgconfig ./configure --host=arm-linux-gnueabihf --prefix=/usr/arm-linux-gnueabihf --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-freetype --without-fontconfig && \
make && \
make install
