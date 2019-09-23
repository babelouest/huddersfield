FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

RUN apk add --no-cache \
		check-dev \
		subunit-dev \
		jansson-dev \
		make \
		gcc \
		g++ \
		util-linux-dev \
		wget \
		cmake \
		mariadb-dev \
		sqlite-dev \
		sqlite \
		postgresql-dev \
		bash

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${HOEL_VERSION} > /opt/HOEL_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
