FROM dockcross/linux-arm64-musl

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apt-get update && apt-get install -y \
    libass-dev \
    libfreetype6-dev \
    libgnutls28-dev \
    libtool \
    libvorbis-dev \
    meson \
    yasm \
    zlib1g-dev \
    libunistring-dev \
    libaom-dev \
    nasm

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build
