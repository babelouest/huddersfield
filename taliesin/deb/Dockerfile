FROM babelouest/deb

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		autoconf \
		libconfig-dev \
		libjansson-dev \
		libsystemd-dev \
		libgnutls28-dev \
		libssl-dev \
		libmicrohttpd-dev \
		libsqlite3-dev \
		libtool \
		libavfilter-dev \
		libavcodec-dev \
		libavformat-dev \
		libavresample-dev \
		libavutil-dev \
		make \
		wget \
		&& (apt-get install -y libmariadbclient-dev || apt-get install -y libmysqlclient-dev)

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG TALIESIN_VERSION
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
		cmake -DWITH_CURL=off .. && \
		make && \
		make install && \
		rm -rf * && \
		cmake -DWITH_CURL=off -DINSTALL_HEADER=off .. && \
		make && \
		make package ; \
		cp libulfius_*.deb /opt/libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \

# Build Taliesin
		cd /opt && \
		wget https://github.com/babelouest/taliesin/archive/v${TALIESIN_VERSION}.tar.gz && \
		tar -zxvf v${TALIESIN_VERSION}.tar.gz && \
		rm v${TALIESIN_VERSION}.tar.gz && \
		cd taliesin-${TALIESIN_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
		make && \
		make package ; \
		cp taliesin_*.deb /opt/taliesin_${TALIESIN_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
    echo taliesin_${TALIESIN_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb >> /opt/packages && \

# make an archive based on 3 pckages
		cd /opt && \
		tar cvz *.deb -f taliesin-full_${TALIESIN_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz && \
    echo taliesin-full_${TALIESIN_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz >> /opt/packages

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
