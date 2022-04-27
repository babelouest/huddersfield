FROM debian:stable-slim

RUN echo "deb http://172.17.0.1:3142/deb.debian.org/debian stable main" > /etc/apt/sources.list
RUN echo "deb http://172.17.0.1:3142/security.debian.org/debian-security stable-security main" >> /etc/apt/sources.list
RUN echo "deb http://172.17.0.1:3142/deb.debian.org/debian stable-updates main" >> /etc/apt/sources.list

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
