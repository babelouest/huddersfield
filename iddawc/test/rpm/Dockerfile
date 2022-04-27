FROM babelouest/rpm

ARG RPMI=yum

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG LIBJANSSON_VERSION

COPY ["*.tar.gz", "/opt/"]

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    check-devel \
    zlib-devel \
    libtool \
    autoconf

RUN ${RPMI} install -y libjansson-devel gnutls || \
    ${RPMI} install -y jansson-devel gnutls-utils

RUN ${RPMI} install -y libmicrohttpd-devel || \
    ${RPMI} install --enablerepo=PowerTools -y libmicrohttpd-devel

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
