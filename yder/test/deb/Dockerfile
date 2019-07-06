FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libsystemd-dev \
		check \
		libsubunit-dev

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
