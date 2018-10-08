FROM babelouest/rpm

# Install required packages
RUN yum install -y \
    jansson-devel \
		systemd-devel \
		sqlite-devel \
		libpq-devel \
    mariadb-devel

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

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
		make install && \
		make package ; \
		cp liborcania-dev_*.rpm /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
# Build Yder
		cd /opt && \
		wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
		tar -zxvf v${YDER_VERSION}.tar.gz && \
		rm v${YDER_VERSION}.tar.gz && \
		cd yder-${YDER_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake -DBUILD_RPM=on .. && \
		make && \
		make install && \
		make package ; \
		cp libyder-dev_*.rpm /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
# Build Hoel
		cd /opt && \
		wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
		tar -zxvf v${HOEL_VERSION}.tar.gz && \
		rm v${HOEL_VERSION}.tar.gz && \
		cd hoel-${HOEL_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake -DBUILD_RPM=on .. && \
		make && \
		make install && \
		make package ; \
		cp libhoel-dev_*.rpm /opt/libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
    echo libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm >> /opt/packages && \
# make an archive based on 3 pckages
		cd /opt && \
		tar cvz *.rpm -f hoel-dev-full_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz && \
    echo hoel-dev-full_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz >> /opt/packages

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
