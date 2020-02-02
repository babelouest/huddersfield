FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG HUTCH_VERSION
ARG LIBJWT_VERSION

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
		wget \
		cmake \
		bash

# libtool and autoconf may be required, install them with 'sudo apt-get install libtool autoconf'
RUN cd /opt && \
		wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz && \
		tar -zxvf v${LIBJWT_VERSION}.tar.gz && \
		rm v${LIBJWT_VERSION}.tar.gz && \
		cd libjwt-${LIBJWT_VERSION}/ && \
		autoreconf -i && \
		./configure --without-openssl && \
		make && \
		make install

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${HUTCH_VERSION} > /opt/HUTCH_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
