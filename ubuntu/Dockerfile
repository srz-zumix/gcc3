FROM ubuntu:18.04
ENV GCC_VERSION=3.4.6
ENV BINUTILS_VERSION=2.30

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends software-properties-common apt-transport-https && \
    apt-get update -q -y && \
    apt-get install -y \
        make wget \
        build-essential flex gcc-multilib g++-multilib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate ftp://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.gz && \
    tar -xzvf binutils-${BINUTILS_VERSION}.tar.gz

RUN wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar -xzvf gcc-${GCC_VERSION}.tar.gz

WORKDIR /build/binutils-${BINUTILS_VERSION}
RUN ./configure --disable-nls --disable-werror && make && make install

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

WORKDIR /build/gcc-${GCC_VERSION}/
RUN ./configure  \
    --disable-nls --disable-threads --disable-shared --disable-werror --disable-bootstrap --enable-languages=c,c++ && \
    make all-gcc && make install-gcc

WORKDIR /
