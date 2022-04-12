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
