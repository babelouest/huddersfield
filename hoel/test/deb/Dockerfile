FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

COPY ["*.tar.gz", "/opt/"]

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libjansson-dev \
		libsystemd-dev \
		libsqlite3-dev \
		sqlite3 \
		libpq-dev \
		default-libmysqlclient-dev \
		check \
		libsubunit-dev

# Install Orcania & Yder dev edition and build tests
RUN cd /opt && \ 
		tar xfv hoel-dev-full_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz && \
		dpkg -i /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		dpkg -i /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		dpkg -i /opt/libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
		tar -zxvf v${HOEL_VERSION}.tar.gz && \
		rm v${HOEL_VERSION}.tar.gz && \
		cd hoel-${HOEL_VERSION}/test && \
		make core && \
		cp core test.sql /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
