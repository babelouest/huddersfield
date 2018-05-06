FROM babelouest/deb

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		autoconf \
		libconfig-dev \
		libsystemd-dev \
		libjansson-dev \
		libgnutls28-dev \
		libssl-dev \
		libmicrohttpd-dev \
		libsqlite3-dev \
		libtool \
		libopenzwave1.5-dev \
		libmpdclient-dev \
		libcurl4-gnutls-dev \
		g++ \
		make \
		wget \
		&& (apt-get install -y libmariadbclient-dev || apt-get install -y libmysqlclient-dev)

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG ANGHARAD_VERSION
ARG BENOIC_VERSION
ARG CARLEON_VERSION
ARG GARETH_VERSION
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
		cp liborcania_*.deb /opt/liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \

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
		cp libyder_*.deb /opt/libyder_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \

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
		cp libhoel_*.deb /opt/libhoel_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \

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
		cp libulfius_*.deb /opt/libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \

# Build Angharad
		cd /opt && \
		wget https://github.com/babelouest/angharad/archive/v${ANGHARAD_VERSION}.tar.gz -O v${ANGHARAD_VERSION}.tar.gz && \
		tar -xvf v${ANGHARAD_VERSION}.tar.gz && \
		rm v${ANGHARAD_VERSION}.tar.gz && \
		wget https://github.com/babelouest/benoic/archive/v${BENOIC_VERSION}.tar.gz -O v${BENOIC_VERSION}.tar.gz && \
		tar -xvf v${BENOIC_VERSION}.tar.gz && \
		rm v${BENOIC_VERSION}.tar.gz && \
		wget https://github.com/babelouest/carleon/archive/v${CARLEON_VERSION}.tar.gz -O v${CARLEON_VERSION}.tar.gz && \
		tar -xvf v${CARLEON_VERSION}.tar.gz && \
		rm v${CARLEON_VERSION}.tar.gz && \
		wget https://github.com/babelouest/gareth/archive/v${GARETH_VERSION}.tar.gz -O v${GARETH_VERSION}.tar.gz && \
		tar -xvf v${GARETH_VERSION}.tar.gz && \
		rm v${GARETH_VERSION}.tar.gz && \
		mv benoic-${BENOIC_VERSION}/* angharad-${ANGHARAD_VERSION}/src/benoic/ && \
		mv carleon-${CARLEON_VERSION}/* angharad-${ANGHARAD_VERSION}/src/carleon/ && \
		mv gareth-${GARETH_VERSION}/* angharad-${ANGHARAD_VERSION}/src/gareth/ && \
		cd angharad-${ANGHARAD_VERSION} && \
		mkdir build && \
		cd build && \
		cmake .. && \
		make && \
		make package; \
		cp angharad_*.deb /opt/angharad_${ANGHARAD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
    echo angharad_${ANGHARAD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb >> /opt/packages && \

# make an archive based on 3 pckages
		cd /opt && \
		tar cvz *.deb -f angharad-full_${ANGHARAD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz && \
    echo angharad-full_${ANGHARAD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz >> /opt/packages

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
