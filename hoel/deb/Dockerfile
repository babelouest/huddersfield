FROM babelouest/deb

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		libjansson-dev \
		libsystemd-dev \
		libsqlite-dev \
		libpq-dev \
		&& (apt-get install -y libmariadbclient-dev || apt-get install -y libmysqlclient-dev) \
		&& rm -rf /var/lib/apt/lists/*

ARG DISTRIB
ARG CODE
ARG ORCANIA_VERSION
ARG YDER_VERSION
ARG HOEL_VERSION

# Build Orcania
RUN cd /opt && \
		wget https://github.com/babelouest/orcania/archive/v${ORCANIA_VERSION}.tar.gz && \
		tar -zxvf v${ORCANIA_VERSION}.tar.gz && \
		rm v${ORCANIA_VERSION}.tar.gz && \
		cd orcania-${ORCANIA_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
		make && \
		make install && \
		make package ; \
		cp liborcania-dev_*.deb /opt/liborcania-dev_${ORCANIA_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# Build Yder
		cd /opt && \
		wget https://github.com/babelouest/yder/archive/v${YDER_VERSION}.tar.gz && \
		tar -zxvf v${YDER_VERSION}.tar.gz && \
		rm v${YDER_VERSION}.tar.gz && \
		cd yder-${YDER_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
		make && \
		make install && \
		make package ; \
		cp libyder-dev_*.deb /opt/libyder-dev_${YDER_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# Build Hoel
		cd /opt && \
		wget https://github.com/babelouest/hoel/archive/v${HOEL_VERSION}.tar.gz && \
		tar -zxvf v${HOEL_VERSION}.tar.gz && \
		rm v${HOEL_VERSION}.tar.gz && \
		cd hoel-${HOEL_VERSION}/ && \
		mkdir build && \
		cd build && \
		cmake .. && \
		make && \
		make install && \
		make package ; \
		cp libhoel-dev_*.deb /opt/libhoel-dev_${HOEL_VERSION}_${DISTRIB}_${CODE}_`uname -m`.deb && \

# make an archive based on 3 pckages
		cd /opt && \
		tar cvz *.deb -f hoel-dev-full_${HOEL_VERSION}_${DISTRIB}_${CODE}_`uname -m`.tar.gz

COPY ["entrypoint.sh", "/"]

CMD ["/entrypoint.sh"]
