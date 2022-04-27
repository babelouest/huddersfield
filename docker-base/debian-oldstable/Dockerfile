FROM debian:oldstable-slim

RUN echo "deb http://172.17.0.1:3142/deb.debian.org/debian oldstable main" > /etc/apt/sources.list
RUN echo "deb http://172.17.0.1:3142/security.debian.org/debian-security oldstable/updates main" >> /etc/apt/sources.list
RUN echo "deb http://172.17.0.1:3142/deb.debian.org/debian oldstable-updates main" >> /etc/apt/sources.list

# Install required packages
RUN apt-get update && \
		apt-get install -y \
		apt-utils \
		git \
		make \
		cmake \
		wget \
		pkg-config \
		lsb-release
