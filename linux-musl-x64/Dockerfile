FROM alpine:3.12

ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apk add --update --no-cache \
    alpine-sdk \
    libass \
    freetype \
    libtool \
    libvorbis \
    meson \
    yasm \
    zlib \
    aom \
    nasm

RUN mkdir -p /ffmpeg/sources /ffmpeg/bin /ffmpeg/build
