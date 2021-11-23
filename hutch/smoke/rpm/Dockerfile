FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG HOEL_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG HUTCH_VERSION

COPY ["hutch-full_*.tar.gz", "/opt/"]

ARG RPMI=yum

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION

RUN ${RPMI} install -y libjansson-devel libmariadb-devel postgresql-server-devel || \
    ${RPMI} install -y jansson-devel mariadb-devel libpq-devel

RUN ${RPMI} install -y libmicrohttpd-devel || \
    ${RPMI} install --enablerepo=PowerTools -y libmicrohttpd-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    sqlite-devel \
    libconfig-devel \
    check-devel \
    zlib-devel

RUN cd /opt && \
    tar xvf ./hutch-full_${HUTCH_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).tar.gz && \
    rpm --install liborcania_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    rpm --install libyder_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    rpm --install --nodeps libhoel_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    rpm --install --nodeps libulfius_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    rpm --install librhonabwy_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    rpm --install libiddawc_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    rpm --install hutch_${HUTCH_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm && \
    mkdir -p /var/cache/hutch && \
    sqlite3 /var/cache/hutch/hutch.db < /usr/share/hutch/doc/hutch.sqlite3.sql && \
    rnbyc -j -g RSA2048 -a RS256 -k RS256 -g EC256 -a ES256 -k ES256 -o /usr/etc/hutch/sign.jwks -p /dev/null && \
    rnbyc -j -g EC256 -a ES256 -o /usr/etc/hutch/private-test.jwks -p /usr/etc/hutch/public-test.jwks

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
