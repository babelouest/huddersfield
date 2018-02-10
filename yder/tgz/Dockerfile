FROM babelouest/tgz

# Install required packages
RUN apk add --no-cache \
    jansson-dev

ARG ORCANIA_VERSION=1.2.0-b.3
ARG YDER_VERSION=1.2.0-b.2

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
    make install && \

# Build Yder
    cd /opt && \
    wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
    tar -zxvf v${YDER_VERSION}.tar.gz && \
    rm v${YDER_VERSION}.tar.gz && \
    cd yder-${YDER_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
    make && \
    make package ; \
		cp libyder-dev_*.tar.gz /opt/libyder-dev_${YDER_VERSION}_Alpine-`cat /etc/alpine-release`-`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
