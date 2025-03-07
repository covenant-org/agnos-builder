#!/bin/bash -e

apt-get update && apt-get install -yq --no-install-recommends \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-rtsp \
    python3-numpy

cd /tmp
git clone --depth=1 -b 4.5.4 https://github.com/opencv/opencv

cd opencv

mkdir build
cd build

cmake -D CMAKE_INSTALL_PREFIX=/usr -D WITH_GSTREAMER=ON -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF ..
make -j$(nproc)
make install
