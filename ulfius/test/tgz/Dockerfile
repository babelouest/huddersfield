FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION

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
		bash

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
