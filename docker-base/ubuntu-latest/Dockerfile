FROM ubuntu:rolling

COPY ["sources.list", "/etc/apt/"]
COPY ["99own", "/etc/apt/apt.conf.d/"]

# Install required packages
RUN apt-get update && \
		apt-get upgrade -y && \
		DEBIAN_FRONTEND=noninteractive apt-get install --allow-unauthenticated -yq \
		apt-utils \
		git \
		make \
		cmake \
		wget \
		pkg-config \
		lsb-release
