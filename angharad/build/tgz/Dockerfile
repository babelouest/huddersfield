FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG ANGHARAD_VERSION
ARG BENOIC_VERSION
ARG CARLEON_VERSION
ARG GARETH_VERSION

# Install required packages
RUN apk add --no-cache \
		autoconf \
		automake \
		libconfig-dev \
		jansson-dev \
		gnutls-dev \
		libgcrypt-dev \
		libmicrohttpd-dev \
		sqlite-dev \
		mariadb-dev \
		libtool \
		make \
		gcc \
		g++ \
		curl-dev \
		openzwave-dev \
		libmpdclient-dev \
		util-linux-dev \
		zlib-dev \
		wget \
		cmake \
		bash

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION
RUN echo ${ANGHARAD_VERSION} > /opt/ANGHARAD_VERSION
RUN echo ${BENOIC_VERSION} > /opt/BENOIC_VERSION
RUN echo ${CARLEON_VERSION} > /opt/CARLEON_VERSION
RUN echo ${GARETH_VERSION} > /opt/GARETH_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
