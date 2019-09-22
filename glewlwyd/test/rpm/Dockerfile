FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

# Install required packages
RUN yum install -y \
		systemd-devel \
		check-devel \
    jansson-devel \
		systemd-devel \
    libcurl-devel \
    gnutls-devel \
    gnutls-utils \
    libmicrohttpd-devel \
		sqlite-devel \
		libpq-devel \
    mariadb-devel \
    liboath-devel \
    libtool \
    autoconf\
    libconfig-devel \
    openldap-devel \
    libcbor-devel && \
		(cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
		tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && ./configure --without-openssl --prefix=/usr && \
    make && make install && ldconfig)

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${GLEWLWYD_VERSION} > /opt/GLEWLWYD_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
