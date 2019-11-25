#!/bin/bash
# 清空上次的编译
make clean
#你自己的NDK路径.
export NDK=/Users/xiaopeng/Android/android-ndk-r15c
function build_android
{
echo "Compiling FFmpeg for $CPU"
./configure \
    --prefix=$PREFIX \
    --enable-neon \
    --enable-hwaccels \
    --enable-gpl \
    --enable-postproc \
    --enable-shared \
    --enable-jni \
    --enable-mediacodec \
    --enable-decoder=h264_mediacodec \
    --disable-static \
    --disable-doc \
    --enable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --enable-avdevice \
    --disable-doc \
    --disable-symver \
    --cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
echo "The Compilation of FFmpeg for $CPU is completed"
}

#armv8-a
# ARCH=arm64
# CPU=armv8-a
# TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/drawin-x86_64
# SYSROOT=$NDK/platforms/android-21/arch-$ARCH/
# CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-march=$CPU"
# build_android


#x86
ARCH=x86
CPU=x86
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/drawin-x86_64
SYSROOT=$NDK/platforms/android-21/arch-$ARCH/
CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-march=$CPU"
build_android