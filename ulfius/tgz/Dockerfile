FROM babelouest/tgz

# Install required packages
RUN apk add --no-cache \
		libcurl \
		jansson-dev \
		gnutls-dev \
		libmicrohttpd-dev \
		curl-dev \
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
		cp liborcania-dev_*.tar.gz /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
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
		make package ; \
		cp libyder-dev_*.tar.gz /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
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
		cp libulfius-dev_*.tar.gz /opt/libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
    echo libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /opt/packages && \
# make an archive based on 3 pckages
		cd /opt && \
		tar cvz *.tar.gz -f ulfius-dev-full_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
    echo ulfius-dev-full_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /opt/packages

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
