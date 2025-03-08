#!/bin/bash -e

apt-get update && apt-get install -yq --no-install-recommends \
    cmake \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-rtsp \
    python3 \
    python3-dev \
    python3-numpy

cd /tmp
git clone --depth=1 -b 4.11.0 https://github.com/opencv/opencv

cd opencv

mkdir build
cd build

CXXFLAGS="-fPIC -O2" cmake -D CMAKE_INSTALL_PREFIX=/usr -D WITH_GSTREAMER=ON -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_TOOLCHAIN_FILE=../platforms/linux/aarch64-gnu.toolchain.cmake ..
CXXFLAGS="-fPIC -O2" make -j$(nproc)
checkinstall -yD --install=no --fstrans=no --pkgname=opencv
mv opencv*.deb /tmp/opencv.deb
