FROM babelouest/tgz

ARG ORCANIA_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
