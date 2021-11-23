FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libconfig-dev \
		libsystemd-dev \
		libjansson-dev \
		libcurl4-gnutls-dev \
		libmicrohttpd-dev \
		libsqlite3-dev \
		libpq-dev \
		libtool \
		zlib1g-dev \
		make \
		wget \
    check \
    libsubunit-dev \
    sqlite3 \
		default-libmysqlclient-dev

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION
RUN echo ${HUTCH_VERSION} > /opt/HUTCH_VERSION

CMD ["/share/hutch/test/deb/entrypoint.sh"]
