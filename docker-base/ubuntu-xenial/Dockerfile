FROM ubuntu:xenial

# Install required packages
RUN apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
		apt-utils \
		git \
		make \
		cmake \
		wget \
		libmicrohttpd-dev \
		libgnutls-dev \
		libcurl4-gnutls-dev \
		pkg-config \
		lsb-release \
		libsqlite3-dev \
		libpq-dev \
		libmysqlclient-dev \
		libconfig-dev \
		libssl-dev \
		libldap2-dev \
		zlib1g-dev \
		liboath-dev \
		clang \
		autoconf \
		automake \
    check \
    gnutls-bin \
    valgrind \
		libtool

RUN wget https://github.com/PJK/libcbor/archive/v0.5.0.tar.gz -O libcbor-0.5.0.tar.gz &&\
    tar xzf libcbor-0.5.0.tar.gz &&\
    mkdir libcbor-0.5.0/build &&\
    cd libcbor-0.5.0/build && cmake .. && make && make install
