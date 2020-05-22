FROM ubuntu:18.04
ENV GCC_VERSION=3.4.6
ENV BINUTILS_VERSION=2.19.1

RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends wget bzip2 build-essential make patch unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN wget --no-check-certificate https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2 && \
    tar jxvf binutils-${BINUTILS_VERSION}.tar.bz2 && \
    wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
    tar xvzf gcc-${GCC_VERSION}.tar.gz

WORKDIR /build/binutils-${BINUTILS_VERSION}
RUN ./configure --target=h8300-elf --disable-nls --disable-werror && \
    make && make install

ADD ./patch /patch
RUN patch /build/gcc-${GCC_VERSION}/gcc/collect2.c /patch/collect2.patch && \
    patch /build/gcc-${GCC_VERSION}/gcc/config/h8300/h8300.c /patch/h8300.patch
WORKDIR /build/gcc-${GCC_VERSION}
RUN ./configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c && \
    make && make install

ENV GCC_EXEC_PREFIX /usr/local/h8300-elf/bin
ENV AR  /usr/local/h8300-elf/bin/ar
ENV AS  /usr/local/h8300-elf/bin/as
ENV CC  /usr/local/h8300-elf/bin/gcc
ENV CXX /usr/local/h8300-elf/bin/gcc
ENV FC  /usr/local/h8300-elf/bin/f77
ENV LD  /usr/local/h8300-elf/bin/ld
ENV NM  /usr/local/h8300-elf/bin/nm
ENV RANLIB /usr/local/h8300-elf/bin/ranlib
ENV SIZE /usr/local/h8300-elf/bin/size
ENV ADDR2LINE /usr/local/h8300-elf/bin/addr2line
ENV GASP /usr/local/h8300-elf/bin/gasp
ENV OBJCOPY /usr/local/h8300-elf/bin/objcopy
ENV OBJDUMP /usr/local/h8300-elf/bin/objdump
ENV STRINGS /usr/local/h8300-elf/bin/strings
ENV STRIP /usr/local/h8300-elf/bin/strip
