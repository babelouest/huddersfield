FROM babelouest/rpm

ARG RPMI=yum

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION

COPY ["*.tar.gz", "/opt/"]

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    check-devel \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    libmicrohttpd-devel

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
