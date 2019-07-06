FROM babelouest/deb

ARG ORCANIA_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		check \
		libsubunit-dev

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
