FROM babelouest/deb

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libsystemd-dev

ARG ORCANIA_VERSION
ARG YDER_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
