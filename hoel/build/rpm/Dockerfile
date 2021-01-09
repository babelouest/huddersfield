FROM babelouest/rpm

ARG RPMI=yum

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    sqlite-devel

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-server-devel || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
