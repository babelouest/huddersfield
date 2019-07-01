FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION

RUN apk add --no-cache \
		check-dev \
		subunit-dev

COPY *.tar.gz /opt/

# Install Orcania & Yder
RUN cd /opt && \
		tar xvf liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
    mv /usr/lib64/liborcania* /usr/lib && \
    mv /usr/lib64/libyder* /usr/lib

# Build tests
RUN wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
		tar -zxvf v${YDER_VERSION}.tar.gz && \
		rm v${YDER_VERSION}.tar.gz && \
		cd yder-${YDER_VERSION}/test && \
		make yder_test && \
		cp yder_test /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
