FROM alpine:latest
ARG GCC_VERSION=3.4.6

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
RUN apk add --no-cache make build-base gmp-dev mpfr-dev mpc1-dev flex && \
    wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar -xzvf gcc-${GCC_VERSION}.tar.gz

WORKDIR /build/gcc-${GCC_VERSION}
RUN sed -i 's/struct siginfo (.*);/siginfo \\1;/g' /build/gcc-${GCC_VERSION}/gcc/config/i386/linux.h && \
    sed -i 's/struct siginfo (.*);/siginfo \\1;/g' /build/gcc-${GCC_VERSION}/gcc/config/i386/linux64.h

RUN ./configure \
    --disable-werror \
    --disable-nls \
    --disable-threads \
    --disable-shared \
    --enable-languages=c,c++ && \
    make && make install
