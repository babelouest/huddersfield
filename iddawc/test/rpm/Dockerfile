FROM babelouest/rpm

ARG RPMI=yum

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION
ARG RHONABWY_VERSION
ARG IDDAWC_VERSION
ARG LIBJWT_VERSION
ARG LIBJANSSON_VERSION

COPY ["*.tar.gz", "/opt/"]

RUN echo ${ORCANIA_VERSION} > /opt/ORCANIA_VERSION
RUN echo ${YDER_VERSION} > /opt/YDER_VERSION
RUN echo ${ULFIUS_VERSION} > /opt/ULFIUS_VERSION
RUN echo ${RHONABWY_VERSION} > /opt/RHONABWY_VERSION
RUN echo ${IDDAWC_VERSION} > /opt/IDDAWC_VERSION

RUN ${RPMI} install -y libjansson-devel || \
    ${RPMI} install -y jansson-devel

# Install required packages
RUN ${RPMI} install -y \
    systemd-devel \
    libcurl-devel \
    gnutls-devel \
    check-devel \
    zlib-devel \
    libtool \
    autoconf\
    libmicrohttpd-devel

# Install jansson from github on Opensuse Leap
RUN if [[ $(lsb_release -sd|tr -d \"|sed 's/[)(]//g') == *"openSUSE Leap"* ]]; then \
    (cd /opt && wget https://github.com/akheron/jansson/archive/v${LIBJANSSON_VERSION}.tar.gz -O libjansson.tar.gz && \
    tar xf libjansson.tar.gz && cd jansson-${LIBJANSSON_VERSION} && autoreconf -i && ./configure && make && make install && ldconfig); \
    else \
    ${RPMI} install -y libjansson-devel || ${RPMI} install -y jansson-devel; \
    fi

RUN (cd /opt && wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O libjwt.tar.gz && \
    tar xf libjwt.tar.gz && cd libjwt-${LIBJWT_VERSION} && autoreconf -i && ./configure --without-openssl --prefix=/usr && \
    make && make install && ldconfig)

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]