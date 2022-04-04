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
