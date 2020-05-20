FROM ubuntu:16.04
ENV GCC_VERSION=3.4.6
ENV BINUTILS_VERSION=2.15
ENV NEWLIB_VERSION=1.12.0

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends software-properties-common apt-transport-https && \
    apt-get update -q -y && \
    apt-get install -y --no-install-recommends \
        make wget build-essential flex bison libelf-dev libc6-dev binutils-dev libdwarf-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate ftp://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 && \
    tar -jxvf binutils-${BINUTILS_VERSION}.tar.bz2

RUN wget --no-check-certificate ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VERSION}.tar.gz && \
    tar -xzvf newlib-${NEWLIB_VERSION}.tar.gz

RUN wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar -xzvf gcc-${GCC_VERSION}.tar.gz

ENV PATH /usr/local/h8300-hms/bin:$PATH
WORKDIR /build/binutils/objdir
RUN ../../binutils-${BINUTILS_VERSION}/configure --target=h8300-hms --prefix=/usr/local --disable-multilib && \
    make CFLAGS="-D_FORTIFY_SOURCE=0" && make install

WORKDIR /build/newlib/objdir
# RUN ../../newlib-${NEWLIB_VERSION}/configure --target=h8300-hms --enable-languages="c,c++" --with-newlib --with-headers=/build/newlib-${NEWLIB_VERSION}/newlib/libc/include --prefix=/usr/local
# RUN make -j4 LANGUAGES="c c++" && make install

# WORKDIR /build/objdir
# RUN ./../gcc-${GCC_VERSION}/configure --target=h8300-hms --prefix=/usr/local --enable-languages=c,c++
# RUN make -j4 && make install
