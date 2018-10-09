FROM babelouest/tgz

# Install required packages
RUN apk add --no-cache \
		autoconf \
		automake \
		libconfig-dev \
		jansson-dev \
		libgcrypt-dev \
		libmicrohttpd-dev \
		sqlite-dev \
		mariadb-dev \
		libtool \
		make \
		gcc \
		g++ \
		util-linux-dev \
		wget \
		cmake \
		bash

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG HUTCH_VERSION
ARG LIBJWT_VERSION

# libtool and autoconf may be required, install them with 'sudo apt-get install libtool autoconf'
RUN mkdir /opt && \
		cd /opt && \
		wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz && \
		tar -zxvf v${LIBJWT_VERSION}.tar.gz && \
		rm v${LIBJWT_VERSION}.tar.gz && \
		cd libjwt-${LIBJWT_VERSION}/ && \
		autoreconf -i && \
		./configure --without-openssl && \
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
		cp liborcania_*.tar.gz /opt/liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
# Build Yder
		cd /opt && \
		wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
		tar -zxvf v${YDER_VERSION}.tar.gz && \
		rm v${YDER_VERSION}.tar.gz && \
		cd yder-${YDER_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake -DWITH_JOURNALD=off .. && \
		make && \
		make install && \
		rm -rf * && \
		cmake -DWITH_JOURNALD=off -DINSTALL_HEADER=off .. && \
		make && \
		make package ; \
		cp libyder_*.tar.gz /opt/libyder_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
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
		cp libhoel_*.tar.gz /opt/libhoel_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
# Build Ulfius
		cd /opt && \
		wget https://github.com/babelouest/ulfius/archive/v${ULFIUS_VERSION}.tar.gz && \
		tar -zxvf v${ULFIUS_VERSION}.tar.gz && \
		rm v${ULFIUS_VERSION}.tar.gz && \
		cd ulfius-${ULFIUS_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake -DWITH_WEBSOCKET=off -DWITH_CURL=off .. && \
		make && \
		make install && \
		rm -rf * && \
		cmake -DWITH_WEBSOCKET=off -DWITH_CURL=off -DINSTALL_HEADER=off .. && \
		make && \
		make package ; \
		cp libulfius_*.tar.gz /opt/libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
# Build Hutch
		cd /opt && \
		wget https://github.com/babelouest/hutch/archive/v${HUTCH_VERSION}.tar.gz && \
		tar -zxvf v${HUTCH_VERSION}.tar.gz && \
		rm v${HUTCH_VERSION}.tar.gz && \
		cd hutch-${HUTCH_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
		make && \
		make package ; \
		cp hutch_*.tar.gz /opt/hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
    echo hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /opt/packages && \
# make an archive based on 3 pckages
		cd /opt && \
		tar cvz *.tar.gz -f hutch-full_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
    echo hutch-full_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /opt/packages

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
