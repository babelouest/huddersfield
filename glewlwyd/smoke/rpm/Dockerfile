FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG GLEWLWYD_VERSION
ARG MEMCHECK

COPY ["glewlwyd-full_*.tar.gz", "/opt/"]

ARG RPMI=yum

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

RUN ${RPMI} install -y libjansson mariadb-connector-c libpq openldap-clients gnutls || \
    ${RPMI} install -y jansson mariadb libpq openldap gnutls-utils

# Install required packages
RUN ${RPMI} install -y \
    libcurl \
    systemd-devel \
    gnutls \
    libmicrohttpd \
    sqlite \
    liboath \
    libtool \
    autoconf\
    libconfig \
    zlib \
    valgrind \
    libcbor

RUN cd /opt && \
	tar xvf ./glewlwyd-full_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).tar.gz && \
	rpm --install liborcania_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	rpm --install libyder_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	rpm --install --nodeps libhoel_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	rpm --install --nodeps libulfius_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	rpm --install librhonabwy_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	rpm --install libiddawc_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	rpm --install glewlwyd_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
	mkdir -p /var/cache/glewlwyd && \
	sqlite3 /var/cache/glewlwyd/glewlwyd.db < /usr/share/glewlwyd/docs/database/init.sqlite3.sql

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
