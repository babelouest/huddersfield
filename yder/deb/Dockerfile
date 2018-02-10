FROM babelouest/deb

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    libjansson-dev

ARG DISTRIB
ARG CODE
ARG ORCANIA_VERSION
ARG YDER_VERSION

# Build Orcania
RUN cd /opt && \
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
		cp libyder-dev_*.deb /opt/libyder-dev_${YDER_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
