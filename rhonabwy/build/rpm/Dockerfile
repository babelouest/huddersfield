FROM babelouest/rpm

ARG RPMI=yum

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    zlib-devel \
    libmicrohttpd-devel

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
