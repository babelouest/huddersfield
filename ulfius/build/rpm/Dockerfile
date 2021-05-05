FROM babelouest/rpm

ARG RPMI=yum

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    zlib-devel

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

RUN ${RPMI} install -y libmicrohttpd-devel || \
    ${RPMI} install --enablerepo=PowerTools -y libmicrohttpd-devel

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
