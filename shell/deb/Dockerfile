FROM babelouest/deb

ARG LIBJANSSON_VERSION
ARG LIBCBOR_VERSION

# Install required packages
RUN apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
		g++ \
		autoconf \
		libconfig-dev \
		libsystemd-dev \
		libjansson-dev \
		libssl-dev \
		libcurl4-gnutls-dev \
		libldap2-dev \
		libmicrohttpd-dev \
		libsqlite3-dev \
		libpq-dev \
		libtool \
		zlib1g-dev \
		make \
		wget \
		liboath-dev \
		valgrind \
		vim \
		bash-completion \
		default-libmysqlclient-dev && \
		apt-get install -y libcbor-dev || \
		(cd /opt && wget https://github.com/PJK/libcbor/archive/v${LIBCBOR_VERSION}.tar.gz -O libcbor.tar.gz && \
		tar xf libcbor.tar.gz && cd libcbor-${LIBCBOR_VERSION} && mkdir build && cd build && cmake .. && make && make install && ldconfig)

# Install libjansson from github on ubuntu Bionic and Debian oldstable
RUN if [ $(lsb_release -cs) = "bionic" ] || [ $(lsb_release -cs) = "stretch" ]; then \
    apt-get remove --purge -y libjansson4; \
    (cd /opt && wget https://github.com/akheron/jansson/archive/v${LIBJANSSON_VERSION}.tar.gz -O jansson.tar.gz && \
    tar xf jansson.tar.gz && cd jansson-${LIBJANSSON_VERSION} && autoreconf -i && ./configure && make && make install && ldconfig) \
    fi

COPY [".bashrc", "/root"]
