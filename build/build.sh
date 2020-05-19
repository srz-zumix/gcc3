#!/bin/sh

GCC_VERSION=$1

mkdir build
cd build
mkdir objdir-${GCC_VERSION}

wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
tar -xzvf gcc-${GCC_VERSION}.tar.gz

if [ -f "gcc-${GCC_VERSION}/contrib/download_prerequisites" ]; then
    ./gcc-${GCC_VERSION}/contrib/download_prerequisites
fi

cd objdir-${GCC_VERSION}

./../gcc-${GCC_VERSION}/configure --prefix=$HOME/GCC-${GCC_VERSION} --disable-multilib --disable-bootstrap --enable-languages=c,c++
make -j4 all-gcc
make -j4 all-target-libgcc
make install-gcc
make install-target-libgcc
