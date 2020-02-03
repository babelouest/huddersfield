FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG LIBJWT_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libtool \
		autoconf \
		libsystemd-dev \
		libjansson-dev \
		libssl-dev \
		libcurl4-gnutls-dev \
		libldap2-dev \
		libgnutls28-dev \
		libmicrohttpd-dev \
		make \
		wget && \
		apt-get install -y libjwt-dev || \
		(cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
		tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && (./configure --without-openssl || ./configure) && make && make install && ldconfig)

# Install jwt from github on ubuntu Bionic
RUN if [ $(lsb_release -cs) = "bionic" ]; then \
    apt-get remove --purge -y libjwt0; \
    (cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
    tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && (./configure --without-openssl || ./configure) && make && make install && ldconfig) \
    fi

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
