FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libcurl4-gnutls-dev \
		libjansson-dev \
		libsystemd-dev \
		libgnutls28-dev \
		libmicrohttpd-dev \
		zlib1g-dev \
		check \
		libtool \
		autoconf \
		libsubunit-dev
		
COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
