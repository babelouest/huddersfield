FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION

COPY ["*.deb", "/opt/"]

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libsystemd-dev \
		check \
		libsubunit-dev

# Install Orcania & Yder dev edition and build tests
RUN dpkg -i /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		dpkg -i /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
		tar -zxvf v${YDER_VERSION}.tar.gz && \
		rm v${YDER_VERSION}.tar.gz && \
		cd yder-${YDER_VERSION}/test && \
		ldconfig  && \
		make yder_test && \
		cp yder_test /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
