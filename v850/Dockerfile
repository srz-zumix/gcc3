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
RUN ./configure --target=v850-elf --disable-nls --disable-werror && \
    make && make install

ADD ./patch /patch
RUN patch /build/gcc-${GCC_VERSION}/gcc/collect2.c /patch/collect2.patch
WORKDIR /build/gcc-${GCC_VERSION}
# RUN ./configure --target=v850-elf --disable-nls --disable-threads --disable-shared --enable-languages=c && \
#     make && make install

# ENV GCC_EXEC_PREFIX /usr/local/v850-elf/bin
# ENV AR  /usr/local/v850-elf/bin/ar
# ENV AS  /usr/local/v850-elf/bin/as
# ENV CC  /usr/local/v850-elf/bin/gcc
# ENV CXX /usr/local/v850-elf/bin/gcc
# ENV FC  /usr/local/v850-elf/bin/f77
# ENV LD  /usr/local/v850-elf/bin/ld
# ENV NM  /usr/local/v850-elf/bin/nm
# ENV RANLIB /usr/local/v850-elf/bin/ranlib
# ENV SIZE /usr/local/v850-elf/bin/size
# ENV ADDR2LINE /usr/local/v850-elf/bin/addr2line
# ENV GASP /usr/local/v850-elf/bin/gasp
# ENV OBJCOPY /usr/local/v850-elf/bin/objcopy
# ENV OBJDUMP /usr/local/v850-elf/bin/objdump
# ENV STRINGS /usr/local/v850-elf/bin/strings
# ENV STRIP /usr/local/v850-elf/bin/strip
