FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG LIBJWT_VERSION

# Install required packages
RUN apk add --no-cache \
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
		libtool \
		bash && \
    (cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
    tar -zxvf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION}/ && autoreconf -i && ./configure --prefix=/usr --without-openssl && \
    make && make install)

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
