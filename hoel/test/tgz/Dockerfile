FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

RUN apk add --no-cache \
		check-dev \
		subunit-dev \
		jansson-dev \
		make \
		gcc \
		g++ \
		util-linux-dev \
		wget \
		cmake \
		mariadb-dev \
		sqlite-dev \
		sqlite \
		postgresql-dev \
		bash

COPY *.tar.gz /opt/

# Install Orcania & Yder
RUN cd /opt && \
		tar xvf hoel-dev-full_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
		tar xvf liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
    mv /usr/lib64/liborcania* /usr/lib && \
    mv /usr/lib64/libyder* /usr/lib && \
    mv /usr/lib64/libhoel* /usr/lib

# Build tests
RUN wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
		tar -zxvf v${HOEL_VERSION}.tar.gz && \
		rm v${HOEL_VERSION}.tar.gz && \
		cd hoel-${HOEL_VERSION}/test && \
		make core && \
		cp core test.sql /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
