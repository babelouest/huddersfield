FROM babelouest/deb

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
RUN apt-get update && \
		apt-get install -y \
		autoconf \
		libconfig-dev \
		libsystemd-dev \
		libjansson-dev \
		libgnutls28-dev \
		libssl-dev \
		libmicrohttpd-dev \
		libsqlite3-dev \
		libtool \
		libmpdclient-dev \
		libcurl4-gnutls-dev \
		zlib1g-dev \
		g++ \
		make \
		wget \
		default-libmysqlclient-dev

RUN apt-get install -y libopenzwave1.5-dev || apt-get install -y libopenzwave1.6-dev

# Install libjansson from github on ubuntu Bionic and Debian oldstable
RUN if [ $(lsb_release -cs) = "bionic" ] || [ $(lsb_release -cs) = "stretch" ]; then \
    apt-get remove --purge -y libjansson4; \
    (cd /opt && wget https://github.com/akheron/jansson/archive/v${LIBJANSSON_VERSION}.tar.gz -O jansson.tar.gz && \
    tar xf jansson.tar.gz && cd jansson-${LIBJANSSON_VERSION} && autoreconf -i && ./configure && make && make install && ldconfig) \
    fi

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
