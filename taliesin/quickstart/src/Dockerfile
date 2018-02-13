FROM alpine:3.7

# Install required packages
RUN apk add --no-cache \
    autoconf \
		automake \
		libtool \
		libcurl \
    jansson-dev \
    make \
		gcc \
		g++ \
    gnutls-dev \
    libconfig \
		libgcrypt \
    libmicrohttpd \
    sqlite-libs \
		mariadb-client-libs \
    wget \
		ffmpeg-libs \
    zlib \
		bash

ARG LIBJWT_VERSION
ARG TALIESIN_VERSION

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

# Download and install Taliesin package
    cd /opt && \
    wget https://github.com/babelouest/taliesin/releases/download/v${TALIESIN_VERSION}/taliesin-full_${TALIESIN_VERSION}_Alpine-3.7-x86_64.tar.gz && \
    tar -xf taliesin-full_${TALIESIN_VERSION}_Alpine-3.7-x86_64.tar.gz && \
    rm taliesin-full_${TALIESIN_VERSION}_Alpine-3.7-x86_64.tar.gz && \
		tar xf liborcania_*.tar.gz && \
		mv liborcania_*/lib64/* /usr/lib && \
		tar xf libyder_*.tar.gz && \
		mv libyder_*/lib64/* /usr/lib && \
		tar xf libulfius_*.tar.gz && \
		mv libulfius_*/lib64/* /usr/lib && \
		tar xf libhoel_*.tar.gz && \
		mv libhoel_*/lib64/* /usr/lib && \
		tar xf taliesin_*.tar.gz && \
		mv taliesin_*/bin/taliesin /usr/bin && \
		mkdir -p /usr/share/taliesin/ && \
		mv taliesin_*/share/taliesin/webapp/ /usr/share/taliesin/ && \
		rm -rf *

COPY ["entrypoint.sh", "/"]

EXPOSE 8576

CMD ["/entrypoint.sh"]
