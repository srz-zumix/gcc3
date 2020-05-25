FROM ubuntu:18.04
ENV GCC_VERSION=3.4.6
ENV BINUTILS_VERSION=2.30
ENV NEWLIB_VERSION=1.19.0

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends software-properties-common apt-transport-https && \
    apt-get update -q -y && \
    apt-get install -y \
        make wget \
        build-essential texinfo flex libc6 libc6-dev gcc-multilib g++-multilib nkf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate ftp://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.gz && \
    tar -xzvf binutils-${BINUTILS_VERSION}.tar.gz && \
    wget --no-check-certificate ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VERSION}.tar.gz && \
    tar -xzvf newlib-${NEWLIB_VERSION}.tar.gz && \
    wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar -xzvf gcc-${GCC_VERSION}.tar.gz

ENV BUILD_TARGET=--target=x86_64-linux
ENV BUILD_HOST=--host=x86_64-linux-gnu

WORKDIR /build/binutils-${BINUTILS_VERSION}
RUN ./configure ${BUILD_TARGET} ${BUILD_HOST} --disable-nls --disable-werror && make && make install

ADD ./patch /patch
RUN patch -d /build/gcc-${GCC_VERSION} -p1 -N < /patch/collect2.patch && \
    sed -i -e 's/struct ucontext \(.*\);/ucontext_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/alpha/linux.h && \
    sed -i -e 's/struct ucontext \(.*\);/ucontext_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/sh/linux.h    && \
    sed -i -e 's/struct ucontext \(.*\);/ucontext_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/i386/linux.h  && \
    sed -i -e 's/struct ucontext \(.*\);/ucontext_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/ia64/linux.h  && \
    sed -i -e 's/struct ucontext \(.*\);/ucontext_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/mips/linux.h  && \
    sed -i -e 's/struct ucontext \(.*\);/ucontext_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/i386/linux64.h && \
    sed -i -e 's/struct siginfo \(.*\);/siginfo_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/alpha/linux.h && \
    sed -i -e 's/struct siginfo \(.*\);/siginfo_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/sh/linux.h    && \
    sed -i -e 's/struct siginfo \(.*\);/siginfo_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/i386/linux.h  && \
    sed -i -e 's/struct siginfo \(.*\);/siginfo_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/ia64/linux.h  && \
    sed -i -e 's/struct siginfo \(.*\);/siginfo_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/mips/linux.h  && \
    sed -i -e 's/struct siginfo \(.*\);/siginfo_t \1;/g' /build/gcc-${GCC_VERSION}/gcc/config/i386/linux64.h

WORKDIR /build/gcc-build/
RUN ../gcc-${GCC_VERSION}/configure ${BUILD_TARGET} ${BUILD_HOST} --without-headers --with-newlib \
    --disable-nls --disable-threads --disable-shared --disable-werror --disable-bootstrap --enable-languages=c,c++ && \
    make all-gcc && make install-gcc

WORKDIR /build/newlib-${NEWLIB_VERSION}/
RUN ./configure ${BUILD_TARGET} ${BUILD_HOST} && \
    make && make install

WORKDIR /build/gcc-${GCC_VERSION}/
RUN ./configure ${BUILD_TARGET} ${BUILD_HOST} \
    --with-newlib \
    --disable-nls --disable-threads --disable-shared --disable-werror --disable-bootstrap --enable-languages=c,c++ && \
    make && make install

WORKDIR /

ENV AR  /usr/local/bin/x86_64-linux-ar
ENV AS  /usr/local/bin/x86_64-linux-as
ENV CC  /usr/local/bin/x86_64-linux-gcc
ENV CXX /usr/local/bin/x86_64-linux-g++
ENV LD  /usr/local/bin/x86_64-linux-ld
ENV NM  /usr/local/bin/x86_64-linux-nm
ENV RANLIB /usr/local/bin/x86_64-linux-ranlib
ENV SIZE /usr/local/bin/x86_64-linux-size
ENV ADDR2LINE /usr/local/bin/x86_64-linux-addr2line
ENV OBJCOPY /usr/local/bin/x86_64-linux-objcopy
ENV OBJDUMP /usr/local/bin/x86_64-linux-objdump
ENV STRINGS /usr/local/bin/x86_64-linux-strings
ENV STRIP /usr/local/bin/x86_64-linux-strip