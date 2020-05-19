FROM alpine:latest
ARG GCC_VERSION=3.4.6

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

RUN apk add --no-cache make build-base

WORKDIR /build
COPY ./build/build.sh /build/build.sh

