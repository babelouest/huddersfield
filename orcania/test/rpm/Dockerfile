FROM babelouest/rpm

ARG ORCANIA_VERSION

COPY *.rpm /opt/

# Install required packages
RUN yum install -y \
		check-devel

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
