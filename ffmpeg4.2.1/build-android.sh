#!/bin/bash
NDK=/Users/xiaopeng/Android/android-ndk-r20
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
API=29

function build_android
{
echo "Compiling FFmpeg for $CPU"

#disable-shared enable-static 不写也可以，默认就是这样的。
#--prefix : 安装目录
#--enable-small : 优化大小
#--disable-programs : 不编译ffmpeg程序(命令行工具)，我们是需要获得静态(动态)库。
#--disable-avdevice : 关闭avdevice模块，此模块在android中无用
#--disable-encoders : 关闭所有编码器 (播放不需要编码)
#--disable-muxers :  关闭所有复用器(封装器)，不需要生成mp4这样的文件，所以关闭
#--disable-filters :关闭视频滤镜
#--enable-cross-compile : 开启交叉编译
#--cross-prefix: gcc的前缀 xxx/xxx/xxx-gcc 则给xxx/xxx/xxx-

#--sysroot: 
#--extra-cflags: 会传给gcc的参数
#--arch --target-os : 必须要给


./configure \
    --prefix=$PREFIX \
    --enable-small \
    --enable-shared \
    --disable-static \
    --disable-hwaccels \
    --disable-gpl \
    --disable-postproc \
    --enable-neon \
    --enable-jni \
    --enable-mediacodec \
    --enable-decoder=h264_mediacodec \
    --disable-programs \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-avdevice \
    --disable-doc \
    --disable-symver \
    --cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make -j 4
make install
echo "The Compilation of FFmpeg for $CPU is completed"
}

# arm64-v8a
ARCH=aarch64
CPU=armv8-a
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
SYSROOT=$TOOLCHAIN/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-march=$CPU"
build_android

# armeabi-v7a
# ARCH=arm
# CPU=armv7-a
# CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
# CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
# SYSROOT=$TOOLCHAIN/sysroot
# CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march "
# build_android

#x86
# ARCH=x86
# CPU=x86
# CC=$TOOLCHAIN/bin/i686-linux-android$API-clang
# CXX=$TOOLCHAIN/bin/i686-linux-android$API-clang++
# SYSROOT=$TOOLCHAIN/sysroot
# CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32"
# build_android

#x86_64
# ARCH=x86_64
# CPU=x86-64
# CC=$TOOLCHAIN/bin/x86_64-linux-android$API-clang
# CXX=$TOOLCHAIN/bin/x86_64-linux-android$API-clang++
# SYSROOT=$TOOLCHAIN/sysroot
# CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-march=$CPU -msse4.2 -mpopcnt -m64 -mtune=intel"
# build_android
