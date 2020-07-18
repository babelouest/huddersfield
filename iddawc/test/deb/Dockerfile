FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG LIBJANSSON_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libcurl4-gnutls-dev \
		libjansson-dev \
		libsystemd-dev \
		libgnutls28-dev \
		libmicrohttpd-dev \
		check \
		libtool \
		autoconf \
		zlib1g-dev \
		libsubunit-dev

# Install jansson from github on Debian stretch
RUN if [ $(lsb_release -cs) = "stretch" ]; then \
    (cd /opt && wget https://github.com/akheron/jansson/archive/v${LIBJANSSON_VERSION}.tar.gz -O libjansson.tar.gz && \
    tar xf libjansson.tar.gz && cd jansson-${LIBJANSSON_VERSION} && autoreconf -i && ./configure && make && make install && ldconfig) \
    fi

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
