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

WORKDIR /build
COPY ./build/build.sh /build/build.sh
