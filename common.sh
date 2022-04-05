#!/bin/bash

DOCKER_DIR_FLAGS=(
    --prefix="/ffmpeg/build"
    --bindir="/ffmpeg/bin"
    --logfile="/ffmpeg/bin/log.txt"
)

NATIVE_DIR_FLAGS=(
    --prefix="${OUT_DIR}/build"
    --bindir="${OUT_DIR}/output"
    --logfile="${OUT_DIR}/output/log.txt"
)

FFMPEG_CONFIGURE_FLAGS=(
    # System libraries
    --disable-autodetect
    --disable-iconv

    # External libraries
    --enable-libdav1d

    # FFMpeg components
    --disable-programs
    --enable-ffprobe

    --disable-avdevice
    --disable-swresample
    --disable-swscale
    --disable-postproc
    --disable-avfilter

    # FFMpeg options - disable all
    --disable-network
    --disable-everything

    # FFMpeg options - enable what we need
    --enable-protocol=file
    --enable-demuxers
    --enable-parsers
    --enable-decoders
    --enable-bsf=av1_frame_split
    --enable-bsf=av1_frame_merge
    --enable-bsf=av1_metadata
)
