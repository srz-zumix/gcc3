FROM centos:centos5

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

SHELL ["/bin/bash", "-l", "-o", "pipefail", "-c"]
RUN yum update -y && \
    yum -y install epel-release && \
    yum install -y make gcc g++ nkf wget perl gettext libffi-devel \
        compat-gcc-34 compat-gcc-34-c++

# RUN yum install -y git && \
#     git config --global http.sslVersion "tlsv1.2"

WORKDIR /usr/local/src
RUN wget --no-check-certificate https://www.openssl.org/source/openssl-1.0.2n.tar.gz && \
    tar zxvf openssl-1.0.2n.tar.gz
WORKDIR /usr/local/src/openssl-1.0.2n
RUN ./config --prefix=/usr shared enable-ssl2 enable-ssl3 && make && make install

WORKDIR /usr/local/src
RUN wget --no-check-certificate wget http://ftp.gnu.org/gnu/wget/wget-1.16.tar.gz && \
    tar zxvf wget-1.16.tar.gz
WORKDIR /usr/local/src/wget-1.16
RUN ./configure --prefix=/usr --with-ssl=openssl && make && make install

WORKDIR /usr/local/src
RUN wget --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz && \
    tar zxvf git-2.9.5.tar.gz && \
    wget --secure-protocol=TLSv1_2 --no-check-certificate https://www.zlib.net/fossils/zlib-1.2.3.9.tar.gz && \
    tar zxvf zlib-1.2.3.9.tar.gz && \
    wget --secure-protocol=TLSv1_2 --no-check-certificate https://curl.haxx.se/download/curl-7.58.0.tar.gz && \
    tar zxvf curl-7.58.0.tar.gz
WORKDIR /usr/local/src/zlib-1.2.3.9
RUN ./configure --prefix=/usr && make && make install
WORKDIR /usr/local/src/curl-7.58.0
RUN ./configure --enable-libcurl-option --with-ssl=/usr --prefix=/usr && make && make install
WORKDIR /usr/local/src/git-2.9.5
RUN ./configure --prefix=/usr && \
    make prefix=/usr all && \
    make prefix=/usr install

ENV LD_LIBRARY_PATH=/usr/lib
RUN wget --no-check-certificate https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer -O - | bash
RUN echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bash_profile && \
    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile
RUN pyenv --version && \
    pyenv install 3.8.2 && \
    pyenv local 3.8.2 && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools tox requests && \
    pip install virtualenv && \
    pyenv local --unset && \
    pyenv global 3.8.2

WORKDIR /

ENV CXX=g++34
ENV CC=gcc34

CMD [ "bash", "-l" ]