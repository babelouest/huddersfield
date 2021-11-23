FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION

COPY ["hutch-full_*.tar.gz", "/opt/"]

# Install required packages
RUN apk add --no-cache \
		sqlite \
		libconfig \
		jansson \
		gnutls \
		libcurl \
		libmicrohttpd \
		sqlite-libs \
		libpq \
		mariadb-connector-c \
		wget \
		cmake \
		autoconf \
		automake \
		zlib \
		libtool && \
		cd /opt && \
		tar xvf ./hutch-full_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
		tar xvf liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libyder_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libhoel_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf librhonabwy_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libiddawc_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		mkdir -p /var/cache/hutch && \
    sqlite3 /var/cache/hutch/hutch.db < /usr/share/hutch/doc/hutch.sqlite3.sql && \
    rnbyc -j -g RSA2048 -a RS256 -k RS256 -g EC256 -a ES256 -k ES256 -o /usr/etc/hutch/sign.jwks -p /dev/null && \
    rnbyc -j -g EC256 -a ES256 -o /usr/etc/hutch/private-test.jwks -p /usr/etc/hutch/public-test.jwks

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
