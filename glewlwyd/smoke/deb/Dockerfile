FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG GLEWLWYD_VERSION
ARG LIBJANSSON_VERSION
ARG LIBCBOR_VERSION

COPY ["glewlwyd-full_*.tar.gz", "/opt/"]

# Install required packages
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	g++ \
	autoconf \
	libtool \
	make \
	wget \
	sqlite3 \
	liboath0 \
	libconfig9 \
	libjansson4 \
	libcurl3-gnutls \
	libmicrohttpd12 \
	libsqlite3-0 \
	libpq5 \
	default-mysql-client \
	default-libmysqlclient-dev \
	zlib1g \
	pkg-config

RUN apt-get install -y libldap-2.4-2 || apt-get install -y libldap-2.5-0

RUN apt-get install -y libcbor0 || apt-get install -y libcbor0.6 || (apt-get install -y wget cmake && \
	cd /opt && wget https://github.com/PJK/libcbor/archive/v${LIBCBOR_VERSION}.tar.gz -O libcbor.tar.gz && \
	tar xf libcbor.tar.gz && cd libcbor-${LIBCBOR_VERSION} && mkdir build && cd build && cmake .. && make && make install && ldconfig)

# Install jansson from github on Debian oldstable
RUN if [ $(lsb_release -cs) = "stretch" ]; then \
    apt-get remove --purge -y libjansson4; \
    (cd /opt && wget https://github.com/akheron/jansson/archive/v${LIBJANSSON_VERSION}.tar.gz -O jansson.tar.gz && \
    tar xf jansson.tar.gz && cd jansson-${LIBJANSSON_VERSION} && autoreconf -i && ./configure && make && make install && ldconfig) \
    fi

RUN cd /opt && \
	tar xvf ./glewlwyd-full_${GLEWLWYD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz && \
	dpkg -i liborcania_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	dpkg -i libyder_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	dpkg -i libhoel_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	dpkg -i libulfius_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	dpkg -i librhonabwy_${RHONABWY_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	dpkg -i libiddawc_${IDDAWC_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	dpkg -i glewlwyd_${GLEWLWYD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
	mkdir -p /var/cache/glewlwyd && \
	sqlite3 /var/cache/glewlwyd/glewlwyd.db < /usr/share/glewlwyd/docs/database/init.sqlite3.sql

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
