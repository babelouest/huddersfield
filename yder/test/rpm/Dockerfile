FROM babelouest/rpm

ARG RPMI=yum

# Install required packages
RUN ${RPMI} install -y \
		systemd-devel \
		check-devel

ARG ORCANIA_VERSION
ARG YDER_VERSION

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
