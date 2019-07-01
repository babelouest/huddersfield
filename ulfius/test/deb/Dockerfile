FROM babelouest/deb

ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG ULFIUS_VERSION

COPY ["*.tar.gz", "/opt/"]

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libcurl4-gnutls-dev \
		libjansson-dev \
		libsystemd-dev \
		libgnutls28-dev \
		libmicrohttpd-dev \
		check \
		libsubunit-dev

# Install Orcania & Yder dev edition and build tests
RUN cd /opt && \ 
		tar xfv ulfius-dev-full_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz && \
		dpkg -i /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		dpkg -i /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		dpkg -i /opt/libulfius-dev_*.deb /opt/libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.deb && \
		wget https://github.com/babelouest/ulfius/archive/v${ULFIUS_VERSION}.tar.gz && \
		tar -zxvf v${ULFIUS_VERSION}.tar.gz && \
		rm v${ULFIUS_VERSION}.tar.gz && \
		cd ulfius-${ULFIUS_VERSION}/test && \
		make u_map core framework websocket && \
		cp u_map core framework websocket /opt/

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
