#!/bin/bash

FFMPEG_CONFIGURE_FLAGS=(
    --prefix="/ffmpeg/build"
    --bindir="/ffmpeg/bin"
    --logfile="/ffmpeg/sources/log.txt"

    --disable-ffplay
    --disable-ffmpeg
    --disable-encoders
    --disable-filters
    --disable-devices
    --disable-muxers
    --disable-protocols
    --enable-protocol=file
    --disable-network
    --disable-doc

    --disable-bsfs
)
