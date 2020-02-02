FROM babelouest/rpm

ARG RPMI=yum

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG LIBJWT_VERSION

COPY ["*.tar.gz", "/opt/"]

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    check-devel \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    libtool \
    autoconf\
    libmicrohttpd-devel && \
    (cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
    tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && ./configure --without-openssl --prefix=/usr && \
    make && make install && ldconfig)

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
