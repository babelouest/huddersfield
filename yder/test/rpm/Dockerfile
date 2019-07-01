FROM babelouest/rpm

# Install required packages
RUN yum install -y \
		systemd-devel \
		check-devel

ARG ORCANIA_VERSION
ARG YDER_VERSION

COPY ["*.rpm", "/opt/"]

# Install Orcania & Yder dev edition and build tests
RUN yum install -y /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		yum install -y /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
		tar -zxvf v${YDER_VERSION}.tar.gz && \
		rm v${YDER_VERSION}.tar.gz && \
		cd yder-${YDER_VERSION}/test && \
		make yder_test && \
		cp yder_test /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
