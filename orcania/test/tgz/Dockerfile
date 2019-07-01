FROM babelouest/tgz

ARG ORCANIA_VERSION

RUN apk add --no-cache \
		check-dev \
		subunit-dev

COPY *.tar.gz /opt/

# Install Orcania
RUN cd /opt && \
		tar xvf liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
    mv /usr/lib64/liborcania* /usr/lib && \
    wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
		tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
		rm v${ORCANIA_VERSION}.tar.gz && \
		cd orcania-${ORCANIA_VERSION}/test/ && \
    make str_test split_test memory_test pointer_list_test && \
		cp str_test split_test memory_test pointer_list_test /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
