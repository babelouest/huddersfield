FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

COPY ["*.tar.gz", "/opt/"]

# Install required packages
RUN yum install -y \
		systemd-devel \
		check-devel \
    jansson-devel \
		systemd-devel \
		sqlite \
		sqlite-devel \
		libpq-devel \
    mariadb-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
