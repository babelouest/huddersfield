FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION
ARG LIBCBOR_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
    bc \
		g++ \
		autoconf \
    sqlite3 \
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
		make \
		wget \
		liboath-dev \
    default-mysql-client \
		default-libmysqlclient-dev \
		check \
    gnutls-bin \
		libsubunit-dev && \
		apt-get install -y libcbor-dev || \
		(cd /opt && wget https://github.com/PJK/libcbor/archive/v${LIBCBOR_VERSION}.tar.gz -O libcbor.tar.gz && \
		tar xf libcbor.tar.gz && cd libcbor-${LIBCBOR_VERSION} && mkdir build && cd build && cmake .. && make && make install && ldconfig) && \
		apt-get install -y libjwt-dev || \
		(cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
		tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && (./configure --without-openssl || ./configure) && make && make install && ldconfig)

# Install jwt from github on ubuntu Bionic
RUN if [ $(lsb_release -cs) = "bionic" ]; then \
    apt-get remove --purge -y libjwt0; \
    (cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
    tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && (./configure --without-openssl || ./configure) && make && make install && ldconfig) \
    fi

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${GLEWLWYD_VERSION} > /opt/GLEWLWYD_VERSION

CMD ["/share/glewlwyd/test/tgz/entrypoint.sh"]
