FROM babelouest/deb

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    libcurl4-gnutls-dev \
    libjansson-dev \
    libgnutls28-dev \
    libmicrohttpd-dev \
    && rm -rf /var/lib/apt/lists/*

ARG DISTRIB
ARG CODE
ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION

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
    make package ; \
		cp liborcania-dev_*.deb /opt/liborcania-dev_${ORCANIA_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

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
		cp libyder-dev_*.deb /opt/libyder-dev_${YDER_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# Build Ulfius
    cd /opt && \
    wget https://github.com/babelouest/ulfius/archive/v${ULFIUS_VERSION}.tar.gz && \
    tar -zxvf v${ULFIUS_VERSION}.tar.gz && \
    rm v${ULFIUS_VERSION}.tar.gz && \
    cd ulfius-${ULFIUS_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
    make && \
    make install && \
    make package ; \
		cp libulfius-dev_*.deb /opt/libulfius-dev_${ULFIUS_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# make an archive based on 3 pckages
    cd /opt && \
    tar cvz *.deb -f ulfius-dev-full_${ULFIUS_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
