FROM ubuntu:14.04
ARG GCC_VERSION=3.3.6

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# RUN apt-get update -q -y && \
#     apt-get install -y --no-install-recommends software-properties-common apt-transport-https
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends \
        make build-essential wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar -xzvf gcc-${GCC_VERSION}.tar.gz

WORKDIR /build/objdir
RUN ./../gcc-${GCC_VERSION}/configure --prefix=$HOME/GCC-${GCC_VERSION} --disable-multilib --disable-bootstrap --enable-languages=c,c++,objc
RUN make -j4 all-gcc
RUN make -j4 all-target-libgcc
RUN make install-gcc
RUN make install-target-libgcc
