FROM babelouest/tgz

# Install required packages
RUN apk add --no-cache \
		jansson-dev

ARG ORCANIA_VERSION

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
		make package ; \
		cp liborcania-dev_*.tar.gz /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
    echo liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /opt/packages

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
