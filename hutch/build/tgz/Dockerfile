FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION

# Install required packages
RUN apk add --no-cache \
		libcurl \
		curl-dev \
		libconfig-dev \
		jansson-dev \
		libgcrypt-dev \
		libmicrohttpd-dev \
		sqlite-dev \
		mariadb-dev \
		postgresql-dev \
		make \
		gcc \
		wget \
		cmake \
		bash

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION
RUN echo ${HUTCH_VERSION} > /opt/HUTCH_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
