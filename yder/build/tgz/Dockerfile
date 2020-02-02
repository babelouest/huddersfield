FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
