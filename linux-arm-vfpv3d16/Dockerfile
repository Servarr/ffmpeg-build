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
    ninja-build \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    pkg-config \
    wget \
    yasm \
    zlib1g-dev \
    nasm \
    gcc-arm-linux-gnueabihf && \
    pip3 install meson

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build

COPY root/ /

RUN git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git /dav1d && \
mkdir -p /dav1d/build && \
cd /dav1d/build && \
meson setup -Denable_tools=false -Denable_tests=false --default-library=static --prefix=/usr/arm-linux-gnueabihf --libdir=/usr/arm-linux-gnueabihf/lib --cross-file=/root/armhf.txt -- .. && \
ninja -v && \
ninja install

RUN mkdir /libbluray && \
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj --strip-components=1 -C /libbluray && \
cd /libbluray && \
CFLAGS=-mfpu=vfpv3-d16 PKG_CONFIG_PATH=/usr/arm-linux-gnueabihf/lib/pkgconfig ./configure --host=arm-linux-gnueabihf --prefix=/usr/arm-linux-gnueabihf --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-libxml2 --without-freetype --without-fontconfig && \
make && \
make install
