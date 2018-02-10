FROM babelouest/deb

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    libjansson-dev

ARG ORCANIA_VERSION=1.2.0-b.3

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
    make package ; \
		cp liborcania-dev_*.deb /opt/liborcania-dev_${ORCANIA_VERSION}_`lsb_release -si`-`lsb_release -sc`-`uname -m`.deb

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
