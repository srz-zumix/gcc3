FROM alpine:latest
ARG GCC_VERSION=3.4.6

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
RUN apk add --no-cache make build-base && \
    wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar -xzvf gcc-${GCC_VERSION}.tar.gz

WORKDIR /build/objdir
RUN ./../gcc-${GCC_VERSION}/configure --prefix=$HOME/GCC-${GCC_VERSION} --disable-multilib --disable-bootstrap --enable-languages=c,c++
RUN make -j4 all-gcc
RUN make -j4 all-target-libgcc
RUN make install-gcc
RUN make install-target-libgcc
