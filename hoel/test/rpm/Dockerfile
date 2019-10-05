FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

ARG RPMI=yum

COPY ["*.tar.gz", "/opt/"]

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    check-devel \
    systemd-devel \
    sqlite \
    sqlite-devel

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-devel || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
