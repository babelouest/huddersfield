FROM babelouest/rpm

ARG ORCANIA_VERSION

COPY *.rpm /opt/

RUN yum install -y /opt/liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		yum remove -y liborcania

# Install required packages
RUN yum install -y \
		check-devel

# Build Orcania
RUN cd /opt && \
		yum install -y /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
		tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
		rm v${ORCANIA_VERSION}.tar.gz && \
		cd orcania-${ORCANIA_VERSION}/test/ && \
		make str_test split_test memory_test pointer_list_test && \
		cp str_test split_test memory_test pointer_list_test /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
