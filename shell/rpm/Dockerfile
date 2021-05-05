FROM babelouest/rpm

ARG RPMI=yum

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-devel openldap2-devel || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel openldap-devel

RUN ${RPMI} install -y libmicrohttpd-devel || \
    ${RPMI} install --enablerepo=PowerTools -y libmicrohttpd-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    sqlite-devel \
    liboath-devel \
    libtool \
    autoconf\
    libconfig-devel \
    zlib-devel
