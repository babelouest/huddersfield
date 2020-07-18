FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION

RUN apk add --no-cache \
		check-dev \
		subunit-dev \
		libcurl \
		jansson-dev \
		gnutls-dev \
		libmicrohttpd-dev \
		curl-dev \
		make \
		gcc \
		g++ \
		util-linux-dev \
		wget \
		cmake \
		autoconf \
		automake \
		zlib-dev \
		libtool \
		bash

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
