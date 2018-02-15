FROM alpine:3.7

# Install required packages
RUN apk add --no-cache \
    autoconf \
		automake \
		libcurl \
    curl-dev \
    libconfig-dev \
    jansson-dev \
    gnutls-dev \
		libgcrypt-dev \
    libmicrohttpd-dev \
    sqlite-dev \
		mariadb-dev \
    libtool \
    make \
    cmake \
		gcc \
		g++ \
    wget \
		ffmpeg-dev \
    zlib-dev \
		bash

ARG DISTRIB
ARG CODE
ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG TALIESIN_VERSION
ARG LIBJWT_VERSION

# libtool and autoconf may be required, install them with 'sudo apt-get install libtool autoconf'
RUN mkdir /opt && \
    cd /opt && \
    wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz && \
    tar -zxvf v${LIBJWT_VERSION}.tar.gz && \
    rm v${LIBJWT_VERSION}.tar.gz && \
    cd libjwt-${LIBJWT_VERSION}/ && \
    autoreconf -i && \
    ./configure --without-openssl && \
    make && \
    make install && \

# Build Orcania
    cd /opt && \
    wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
    tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
    rm v${ORCANIA_VERSION}.tar.gz && \
    cd orcania-${ORCANIA_VERSION}/ && \
		mkdir build && \
		cd build && \
    cmake .. && \
    make && \
    make install && \
    rm -rf * && \
		cmake -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp liborcania_*.tar.gz /opt/liborcania_${ORCANIA_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# Build Yder
    cd /opt && \
    wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
    tar -zxvf v${YDER_VERSION}.tar.gz && \
    rm v${YDER_VERSION}.tar.gz && \
    cd yder-${YDER_VERSION}/ && \
		mkdir build && \
		cd build && \
    cmake .. && \
    make && \
    make install && \
    rm -rf * && \
		cmake -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp libyder_*.tar.gz /opt/libyder_${YDER_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# Build Hoel
    cd /opt && \
    wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
    tar -zxvf v${HOEL_VERSION}.tar.gz && \
    rm v${HOEL_VERSION}.tar.gz && \
    cd hoel-${HOEL_VERSION}/ && \
		mkdir build && \
		cd build && \
    cmake -DWITH_PGSQL=off .. && \
    make && \
    make install && \
    rm -rf * && \
		cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp libhoel_*.tar.gz /opt/libhoel_${HOEL_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# Build Ulfius
    cd /opt && \
    wget https://github.com/babelouest/ulfius/archive/v${ULFIUS_VERSION}.tar.gz && \
    tar -zxvf v${ULFIUS_VERSION}.tar.gz && \
    rm v${ULFIUS_VERSION}.tar.gz && \
    cd ulfius-${ULFIUS_VERSION}/ && \
		mkdir build && \
		cd build && \
    cmake -DWITH_CURL=off .. && \
    make && \
    make install && \
    rm -rf * && \
		cmake -DWITH_CURL=off -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp libulfius_*.tar.gz /opt/libulfius_${ULFIUS_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# Build Taliesin
    cd /opt && \
    wget https://github.com/babelouest/taliesin/archive/v${TALIESIN_VERSION}.tar.gz && \
    tar -zxvf v${TALIESIN_VERSION}.tar.gz && \
    rm v${TALIESIN_VERSION}.tar.gz && \
    cd taliesin-${TALIESIN_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
    make && \
    make package ; \
		cp taliesin_*.tar.gz /opt/taliesin_${TALIESIN_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# make an archive based on 3 pckages
    cd /opt && \
    tar cvz *.tar.gz -f taliesin-full_${TALIESIN_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
