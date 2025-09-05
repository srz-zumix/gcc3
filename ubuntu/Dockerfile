FROM ubuntu:18.04

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

WORKDIR /build
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install basic dependencies
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        apt-transport-https \
        wget \
        gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Debian Lenny repositories to install gcc-3.4
# Using [trusted=yes] to avoid GPG key issues with the old repository.
RUN echo "deb [trusted=yes] http://snapshot.debian.org/archive/debian/20070730T000000Z/ lenny main" > /etc/apt/sources.list.d/lenny.list && \
    echo "deb-src [trusted=yes] http://snapshot.debian.org/archive/debian/20070730T000000Z/ lenny main" >> /etc/apt/sources.list.d/lenny.list && \
    echo "deb [trusted=yes] http://snapshot.debian.org/archive/debian-security/20070730T000000Z/ lenny/updates main" >> /etc/apt/sources.list.d/lenny.list && \
    echo "deb-src [trusted=yes] http://snapshot.debian.org/archive/debian-security/20070730T000000Z/ lenny/updates main" >> /etc/apt/sources.list.d/lenny.list


# Install gcc-3.4 and g++-3.4
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends gcc-3.4 g++-3.4 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables to use gcc-3.4
ENV CC /usr/bin/gcc-3.4
ENV CXX /usr/bin/g++-3.4

WORKDIR /
