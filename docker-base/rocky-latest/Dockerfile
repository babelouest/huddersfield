FROM rockylinux/rockylinux:latest

# Install base packages
RUN yum -y update &&\
    yum install -y gcc \
    gcc-c++ \
    make \
    rpm-build \
    rpmdevtools \
    redhat-lsb \
    openssl-devel \
    wget

# enable powertools repo
RUN dnf -y install dnf-plugins-core && \
    dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf config-manager --set-enabled powertools

COPY ["cmake-3.23.1-Linux-x86_64.tar.gz", "/opt"]

RUN tar xvf /opt/cmake-3.23.1-Linux-x86_64.tar.gz -C /usr/ --strip 1
