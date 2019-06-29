FROM babelouest/deb

ARG ORCANIA_VERSION

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		check \
		libsubunit-dev

COPY *.deb /opt/

# Build Orcania
RUN cd /opt && \
		dpkg -i /opt/liborcania-dev_2.0.0_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
		tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
		rm v${ORCANIA_VERSION}.tar.gz && \
		cd orcania-${ORCANIA_VERSION}/test/ && \
		make str_test split_test memory_test pointer_list_test && \
		cp str_test split_test memory_test pointer_list_test /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
