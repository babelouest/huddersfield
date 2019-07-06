FROM babelouest/rpm

# Install required packages
RUN yum install -y \
    jansson-devel \
		systemd-devel \
		sqlite-devel \
		libpq-devel \
    mariadb-devel

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
