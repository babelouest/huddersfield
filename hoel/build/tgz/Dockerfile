FROM babelouest/tgz

# Install required packages
RUN apk add --no-cache \
		jansson-dev \
		make \
		gcc \
		g++ \
		util-linux-dev \
		wget \
		cmake \
		mariadb-dev \
		sqlite-dev \
		postgresql-dev \
		bash

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
