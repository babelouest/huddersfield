FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION
ARG LIBCBOR_VERSION
ARG MEMCHECK

# Install required packages
RUN apk add --no-cache \
    autoconf \
    automake \
    bc \
    check-dev \
    subunit-dev \
    libcurl \
    curl-dev \
    libconfig-dev \
    jansson-dev \
    libgcrypt-dev \
		gnutls-dev \
    gnutls-utils \
    sqlite \
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
    valgrind \
		libmicrohttpd-dev \
    zlib-dev \
    oath-toolkit-dev

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION
RUN echo ${HUTCH_VERSION} > /opt/HUTCH_VERSION
RUN echo ${MEMCHECK} > /opt/MEMCHECK

CMD ["/share/hutch/test/tgz/entrypoint.sh"]
