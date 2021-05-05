FROM centos:latest

# Install base packages
RUN yum -y update &&\
    yum install -y gcc \
    make \
    cmake \
    rpm-build \
    rpmdevtools \
    redhat-lsb \
    wget

# enable powertools repo
RUN dnf -y install dnf-plugins-core && \
    dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf config-manager --set-enabled powertools
