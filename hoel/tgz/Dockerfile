FROM alpine:3.7

# Install required packages
RUN apk add --no-cache \
    jansson-dev \
    make \
		gcc \
		g++ \
		util-linux-dev \
    wget \
		cmake \
    mariadb-dev \
    sqlite-dev \
    postgresql-dev \
		bash

ARG DISTRIB
ARG CODE
ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

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
    make package ; \
		cp liborcania-dev_*.tar.gz /opt/liborcania-dev_${ORCANIA_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

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
    make install && \
    make package ; \
		cp libyder-dev_*.tar.gz /opt/libyder-dev_${YDER_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# Build Hoel
    cd /opt && \
    wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
    tar -zxvf v${HOEL_VERSION}.tar.gz && \
    rm v${HOEL_VERSION}.tar.gz && \
    cd hoel-${HOEL_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
    make && \
    make install && \
    make package ; \
		cp libhoel-dev_*.tar.gz /opt/libhoel-dev_${HOEL_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz && \

# make an archive based on 3 pckages
    cd /opt && \
    tar cvz *.tar.gz -f hoel-dev-full_${HOEL_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
