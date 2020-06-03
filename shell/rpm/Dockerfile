FROM babelouest/rpm

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-devel openldap2-devel || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel openldap-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    libmicrohttpd-devel \
    sqlite-devel \
    liboath-devel \
    libtool \
    autoconf\
    libconfig-devel \
    zlib-devel \
    libcbor-devel
