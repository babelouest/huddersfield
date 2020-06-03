FROM babelouest/tgz

ARG LIBCBOR_VERSION

# Install required packages
RUN apk add --no-cache \
		autoconf \
		automake \
		libcurl \
		curl-dev \
		libconfig-dev \
		jansson-dev \
		libgcrypt-dev \
		libmicrohttpd-dev \
		sqlite-dev \
		mariadb-dev \
		postgresql-dev \
		libtool \
		make \
		gcc \
		g++ \
		util-linux-dev \
		openldap-dev \
		wget \
		cmake \
		bash \
		zlib-dev \
		oath-toolkit-dev && \
		(cd /opt && wget https://github.com/PJK/libcbor/archive/v${LIBCBOR_VERSION}.tar.gz -O libcbor.tar.gz && \
		tar xf libcbor.tar.gz && cd libcbor-${LIBCBOR_VERSION} && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib .. && make && make install)
