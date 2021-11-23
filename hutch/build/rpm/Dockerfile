FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION

ARG RPMI=yum

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-server-devel || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel

RUN ${RPMI} install -y libmicrohttpd-devel || \
    ${RPMI} install --enablerepo=PowerTools -y libmicrohttpd-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    sqlite-devel \
    libconfig-devel \
    zlib-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION
RUN echo ${HUTCH_VERSION} > /opt/HUTCH_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
