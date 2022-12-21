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
    gcc-aarch64-linux-gnu

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build

COPY root/ /

RUN git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git /dav1d && \
mkdir -p /dav1d/build && \
cd /dav1d/build && \
meson setup -Denable_tools=false -Denable_tests=false --default-library=static --prefix=/usr/aarch64-linux-gnu --libdir=/usr/aarch64-linux-gnu/lib --cross-file=/root/aarch64.txt -- .. && \
ninja && \
ninja install

RUN mkdir /zlib && \
wget -qO- https://zlib.net/zlib-1.2.13.tar.gz | tar xz --strip-components=1 -C /zlib && \
cd /zlib && \
CHOST=aarch64-linux-gnu ./configure --prefix=/usr/aarch64-linux-gnu --static && \
make && \
make install

RUN mkdir /libxml2 && \
wget -qO- https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.1.tar.xz | tar xJ --strip-components=1 -C /libxml2 && \
cd /libxml2 && \
./configure --host=aarch64-linux-gnu --prefix=/usr/aarch64-linux-gnu --disable-shared --disable-dependency-tracking --disable-silent-rules --without-python && \
make && \
make install

RUN mkdir /libbluray && \
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj --strip-components=1 -C /libbluray && \
cd /libbluray && \
PKG_CONFIG_PATH=/usr/aarch64-linux-gnu/lib/pkgconfig ./configure --host=aarch64-linux-gnu --prefix=/usr/aarch64-linux-gnu --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-freetype --without-fontconfig && \
make && \
make install
