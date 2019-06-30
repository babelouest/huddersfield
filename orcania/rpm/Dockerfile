FROM babelouest/rpm

ARG ORCANIA_VERSION

# Build Orcania
RUN cd /opt && \
		wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
		tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
		rm v${ORCANIA_VERSION}.tar.gz && \
		cd orcania-${ORCANIA_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake -DBUILD_RPM=on .. && \
		make && \
		make package ; \
		cp liborcania-dev_*.rpm /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
    echo liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm >> /opt/packages && \
		rm -rf * && \
		cmake -DINSTALL_HEADER=off -DBUILD_RPM=on .. && \
		make && \
		make package ; \
		cp liborcania_*.rpm /opt/liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
