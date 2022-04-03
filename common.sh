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
    --disable-iconv
    --disable-bzlib
    --disable-v4l2-m2m

    --disable-programs
    --enable-ffprobe

    --disable-avdevice
    --disable-swresample
    --disable-swscale
    --disable-postproc
    --disable-avfilter
    
    --disable-network
    --disable-everything

    --enable-protocol=file
    --enable-demuxers
    --enable-parsers
    --enable-decoders
    --enable-bsf=av1_frame_split
    --enable-bsf=av1_frame_merge
    --enable-bsf=av1_metadata
)
