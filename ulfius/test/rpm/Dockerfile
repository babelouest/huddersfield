FROM babelouest/rpm

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION

COPY ["*.tar.gz", "/opt/"]

# Install required packages
RUN yum install -y \
		systemd-devel \
		check-devel \
    jansson-devel \
		systemd-devel \
    libcurl-devel \
    gnutls-devel \
    libmicrohttpd-devel

# Install Orcania & Yder dev edition and build tests
RUN cd /opt && \ 
		tar xfv ulfius-dev-full_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz && \
		yum install -y /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		yum install -y /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		yum install -y /opt/libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm && \
		wget https://github.com/babelouest/ulfius/archive/v${ULFIUS_VERSION}.tar.gz && \
		tar -zxvf v${ULFIUS_VERSION}.tar.gz && \
		rm v${ULFIUS_VERSION}.tar.gz && \
		cd ulfius-${ULFIUS_VERSION}/test && \
		make u_map core framework websocket && \
		cp u_map core framework websocket /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
