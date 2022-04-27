FROM babelouest/tgz

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG GLEWLWYD_VERSION
ARG LIBCBOR_VERSION

COPY ["glewlwyd-full_*.tar.gz", "/opt/"]

# Install required packages
RUN apk add --no-cache \
		sqlite \
		libconfig \
		jansson \
		gnutls \
		libcurl \
		libldap \
		libmicrohttpd \
		sqlite-libs \
		libpq \
		oath-toolkit-liboath \
		mariadb-connector-c \
		wget \
		cmake \
		autoconf \
		automake \
		zlib \
		libtool \
    libcbor && \
		cd /opt && \
		tar xvf ./glewlwyd-full_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz && \
		tar xvf liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libyder_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libhoel_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf librhonabwy_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf libiddawc_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		tar xvf glewlwyd_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1 && \
		mkdir -p /var/cache/glewlwyd && \
		sqlite3 /var/cache/glewlwyd/glewlwyd.db < /usr/share/glewlwyd/docs/database/init.sqlite3.sql

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
