FROM babelouest/deb

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libjansson-dev \
		libsystemd-dev \
		libsqlite3-dev \
		libpq-dev \
		default-libmysqlclient-dev

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
