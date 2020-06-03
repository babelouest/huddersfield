FROM ubuntu:rolling

# Install required packages
RUN apt-get update && \
		apt-get upgrade -y && \
		DEBIAN_FRONTEND=noninteractive apt-get install -yq \
		apt-utils \
		git \
		make \
		cmake \
		wget \
		pkg-config \
		lsb-release
