FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG GLEWLWYD_VERSION
ARG MEMCHECK

ARG RPMI=yum

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-devel openldap2-devel gnutls || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel openldap-devel gnutls-utils

RUN ${RPMI} install -y libmicrohttpd-devel || \
    ${RPMI} install --enablerepo=PowerTools -y libmicrohttpd-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    check-devel \
    libcurl-devel \
    gnutls-devel \
    sqlite-devel \
    liboath-devel \
    libtool \
    autoconf\
    libconfig-devel \
    zlib-devel \
    valgrind \
    libcbor-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION
RUN echo ${GLEWLWYD_VERSION} > /opt/GLEWLWYD_VERSION
RUN echo ${MEMCHECK} > /opt/MEMCHECK

CMD ["/share/glewlwyd/test/rpm/entrypoint.sh"]
