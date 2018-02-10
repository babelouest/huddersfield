FROM babelouest/tgz

# Install required packages
RUN apk add --no-cache \
    jansson-dev

ARG ORCANIA_VERSION=1.2.0-b.3

# Build Orcania
RUN mkdir /opt && \
    cd /opt && \
    wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
    tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
    rm v${ORCANIA_VERSION}.tar.gz && \
    cd orcania-${ORCANIA_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
    make && \
    make package ; \
		cp liborcania-dev_*.tar.gz /opt/liborcania-dev_${ORCANIA_VERSION}_Alpine-`cat /etc/alpine-release`-`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
