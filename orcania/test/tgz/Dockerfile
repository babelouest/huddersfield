FROM babelouest/tgz

ARG ORCANIA_VERSION

RUN apk add --no-cache \
		check-dev \
		subunit-dev

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
