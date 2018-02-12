FROM babelouest/deb

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    libconfig-dev \
    libjansson-dev \
    libgnutls28-dev \
    libssl-dev \
    libcurl4-gnutls-dev \
    libldap2-dev \
    libmicrohttpd-dev \
    libsqlite3-dev \
    libtool \
    make \
    uuid-dev \
    wget \
    && (apt-get install -y libmariadbclient-dev || apt-get install -y libmysqlclient-dev) \
    && rm -rf /var/lib/apt/lists/*

ARG DISTRIB
ARG CODE
ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION

# libtool and autoconf may be required, install them with 'sudo apt-get install libtool autoconf'
RUN cd /opt && \
    wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz && \
    tar -zxvf v${LIBJWT_VERSION}.tar.gz && \
    rm v${LIBJWT_VERSION}.tar.gz && \
    cd libjwt-${LIBJWT_VERSION}/ && \
    autoreconf -i && \
    (./configure --without-openssl || ./configure) && \
    make && \
    make install && \

# Build Orcania
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
    rm -rf * && \
		cmake -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp liborcania_*.deb /opt/liborcania_${ORCANIA_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

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
    rm -rf * && \
		cmake -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp libyder_*.deb /opt/libyder_${YDER_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# Build Hoel
    cd /opt && \
    wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
    tar -zxvf v${HOEL_VERSION}.tar.gz && \
    rm v${HOEL_VERSION}.tar.gz && \
    cd hoel-${HOEL_VERSION}/ && \
		mkdir build && \
		cd build && \
    cmake -DWITH_PGSQL=off .. && \
    make && \
    make install && \
    rm -rf * && \
		cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp libhoel_*.deb /opt/libhoel_${HOEL_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# Build Ulfius
    cd /opt && \
    wget https://github.com/babelouest/ulfius/archive/v${ULFIUS_VERSION}.tar.gz && \
    tar -zxvf v${ULFIUS_VERSION}.tar.gz && \
    rm v${ULFIUS_VERSION}.tar.gz && \
    cd ulfius-${ULFIUS_VERSION}/ && \
		mkdir build && \
		cd build && \
    cmake -DWITH_WEBSOCKET=off .. && \
    make && \
    make install && \
    rm -rf * && \
		cmake -DWITH_WEBSOCKET=off -DINSTALL_HEADER=off .. && \
    make && \
    make package ; \
		cp libulfius_*.deb /opt/libulfius_${ULFIUS_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# Build Glewlwyd
    cd /opt && \
    wget https://github.com/babelouest/glewlwyd/archive/v${GLEWLWYD_VERSION}.tar.gz && \
    tar -zxvf v${GLEWLWYD_VERSION}.tar.gz && \
    rm v${GLEWLWYD_VERSION}.tar.gz && \
    cd glewlwyd-${GLEWLWYD_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
    make && \
    make package ; \
		cp glewlwyd_*.deb /opt/glewlwyd_${GLEWLWYD_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# make an archive based on 3 pckages
    cd /opt && \
    tar cvz *.deb -f glewlwyd-full_${GLEWLWYD_VERSION}_${DISTRIB}-${CODE}-`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
