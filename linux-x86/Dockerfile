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
    gcc-i686-linux-gnu && \
    pip3 install meson

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build

COPY root/ /

RUN git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git /dav1d && \
mkdir -p /dav1d/build && \
cd /dav1d/build && \
meson setup -Denable_tools=false -Denable_tests=false --default-library=static --prefix=/usr/i686-linux-gnu --libdir=/usr/i686-linux-gnu/lib --cross-file=/root/x86.txt -- .. && \
ninja && \
ninja install

RUN mkdir /zlib && \
wget -qO- https://zlib.net/zlib-1.2.13.tar.gz | tar xz --strip-components=1 -C /zlib && \
cd /zlib && \
CHOST=i686-linux-gnu ./configure --prefix=/usr/i686-linux-gnu --static && \
make && \
make install

RUN mkdir /libxml2 && \
wget -qO- https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.1.tar.xz | tar xJ --strip-components=1 -C /libxml2 && \
cd /libxml2 && \
./configure --host=i686-linux-gnu --prefix=/usr/i686-linux-gnu --disable-shared --disable-dependency-tracking --disable-silent-rules --without-python && \
make && \
make install

RUN mkdir /libbluray && \
wget -qO- https://download.videolan.org/videolan/libbluray/1.3.4/libbluray-1.3.4.tar.bz2 | tar xj --strip-components=1 -C /libbluray && \
cd /libbluray && \
PKG_CONFIG_PATH=/usr/i686-linux-gnu/lib/pkgconfig ./configure --host=i686-linux-gnu --prefix=/usr/i686-linux-gnu --disable-shared --disable-dependency-tracking --disable-silent-rules --disable-bdjava-jar --disable-examples --without-external-libudfread --without-freetype --without-fontconfig && \
make && \
make install
