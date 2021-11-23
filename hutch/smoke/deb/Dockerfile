FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION

COPY ["hutch-full_*.tar.gz", "/opt/"]

# Install required packages
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
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

RUN cd /opt && \
    tar xvf ./hutch-full_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz && \
    dpkg -i liborcania_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    dpkg -i libyder_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    dpkg -i libhoel_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    dpkg -i libulfius_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    dpkg -i librhonabwy_${RHONABWY_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    dpkg -i libiddawc_${IDDAWC_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    dpkg -i hutch_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb && \
    mkdir -p /var/cache/hutch && \
    sqlite3 /var/cache/hutch/hutch.db < /usr/share/hutch/doc/hutch.sqlite3.sql && \
    rnbyc -j -g RSA2048 -a RS256 -k RS256 -g EC256 -a ES256 -k ES256 -o /usr/etc/hutch/sign.jwks -p /dev/null && \
    rnbyc -j -g EC256 -a ES256 -o /usr/etc/hutch/private-test.jwks -p /usr/etc/hutch/public-test.jwks

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
