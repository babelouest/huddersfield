FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG RPMI=yum

COPY *.rpm /opt/

# Install required packages
RUN ${RPMI} install -y \
		check-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
