FROM centos:centos5

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y && \
    yum install -y make gcc g++ \
        compat-gcc-34-3.4.6-4.1.x86_64 compat-gcc-34-c++-3.4.6-4.1.x86_64
