FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG TALIESIN_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		autoconf \
		libconfig-dev \
		libjansson-dev \
		libsystemd-dev \
		libgnutls28-dev \
		libssl-dev \
		libmicrohttpd-dev \
		libcurl4-gnutls-dev \
		libsqlite3-dev \
		libtool \
		libavfilter-dev \
		libavcodec-dev \
		libavformat-dev \
		libswresample-dev \
		libavutil-dev \
		make \
		wget \
		zlib1g-dev \
		default-libmysqlclient-dev

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
RUN echo ${TALIESIN_VERSION} > /opt/TALIESIN_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
