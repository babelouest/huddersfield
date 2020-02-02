FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION
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
		oath-toolkit-dev && \
		(cd /opt && wget https://github.com/PJK/libcbor/archive/v${LIBCBOR_VERSION}.tar.gz -O libcbor.tar.gz && \
		tar xf libcbor.tar.gz && cd libcbor-${LIBCBOR_VERSION} && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib .. && make && make install) && \
    (cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
    tar -zxvf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION}/ && autoreconf -i && ./configure --prefix=/usr --without-openssl && \
    make && make install)

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${GLEWLWYD_VERSION} > /opt/GLEWLWYD_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
