#
# package builder root Makefile
# build packages for all environments for the following projects:
#
# - orcania (https://github.com/babelouest/hoel)
# - yder (https://github.com/babelouest/yder)
# - ulfius (https://github.com/babelouest/ulfius)
# - hoel (https://github.com/babelouest/hoel)
# - glewlwyd (https://github.com/babelouest/glewlwyd)
# - taliesin (https://github.com/babelouest/taliesin)
# - hutch (https://github.com/babelouest/hutch)
# - angharad (https://github.com/babelouest/angharad)
#
# Copyright 2018 Nicolas Mora <mail@babelouest.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the MIT License
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU GENERAL PUBLIC LICENSE for more details.
#

GITHUB_UPLOAD=0
LOCAL_UPDATE_SYSTEM=0
LOCAL_INSTALL_LIBJWT=0
GITHUB_USER=babelouest
GITHUB_TOKEN=$(shell cat GITHUB_TOKEN)
LOCAL_ID=$(shell grep -e "^ID=" /etc/os-release |cut -c 4-)
LOCAL_RELEASE=$(shell lsb_release -c -s)

ifeq (($(GITHUB_TOKEN)),"")
	AUTH_HEADER=
else
	AUTH_HEADER=-H "Authorization: token $(GITHUB_TOKEN)"
endif

ORCANIA_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/orcania/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
YDER_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/yder/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
ULFIUS_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/ulfius/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
HOEL_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/hoel/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
GLEWLWYD_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/glewlwyd/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
TALIESIN_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/taliesin/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
HUTCH_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/hutch/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
ANGHARAD_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/angharad/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
BENOIC_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/benoic/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
CARLEON_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/carleon/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
GARETH_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/gareth/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
LIBJWT_VERSION=1.10.0

all: debian-stable-build debian-testing-build ubuntu-latest-build ubuntu-lts-build alpine-build fedora-build

debian-stable-build: orcania-debian-stable yder-debian-stable ulfius-debian-stable hoel-debian-stable glewlwyd-debian-stable taliesin-debian-stable angharad-debian-stable hutch-debian-stable

debian-testing-build: orcania-debian-testing yder-debian-testing ulfius-debian-testing hoel-debian-testing glewlwyd-debian-testing taliesin-debian-testing hutch-debian-testing angharad-debian-testing

ubuntu-latest-build: orcania-ubuntu-latest yder-ubuntu-latest ulfius-ubuntu-latest hoel-ubuntu-latest glewlwyd-ubuntu-latest taliesin-ubuntu-latest hutch-ubuntu-latest angharad-ubuntu-latest

ubuntu-lts-build: orcania-ubuntu-lts yder-ubuntu-lts ulfius-ubuntu-lts hoel-ubuntu-lts glewlwyd-ubuntu-lts taliesin-ubuntu-lts hutch-ubuntu-lts angharad-ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" = "$(shell docker images -q ubuntu:rolling)" ]; then \
		echo "Current Ubuntu LTS release is the same than latest release, ignore ubuntu-lts-build target"; \
	fi

alpine-build: orcania-alpine yder-alpine ulfius-alpine hoel-alpine glewlwyd-alpine taliesin-alpine hutch-alpine angharad-alpine

fedora-build: orcania-fedora yder-fedora ulfius-fedora hoel-fedora

local-build-deb: orcania-local-deb yder-local-deb ulfius-local-deb hoel-local-deb glewlwyd-local-deb taliesin-local-deb hutch-local-deb angharad-local-deb

upload-asset:
	@if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
		for CUR_FILE in $(PATTERN); do \
			./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=$(REPO) tag=v$(TAG) filename=$$CUR_FILE; \
		done; \
	fi

clean-base:
	-docker rmi -f babelouest/deb babelouest/tgz
	/bin/rm -rf build/*

clean: orcania-clean yder-clean ulfius-clean hoel-clean glewlwyd-clean taliesin-clean hutch-clean angharad-clean clean-base clean-no-tag-images

clean-no-tag-images:
	-docker rmi -f $(shell docker images -f "dangling=true" -q)

debian-stable:
	@docker build -t babelouest/deb docker-base/debian-stable/

debian-testing:
	docker build -t babelouest/deb docker-base/debian-testing/

ubuntu-latest:
	docker build -t babelouest/deb docker-base/ubuntu-latest/

ubuntu-lts:
	docker build -t babelouest/deb docker-base/ubuntu-lts/

alpine:
	docker build -t babelouest/tgz docker-base/alpine-current/

fedora:
	docker build -t babelouest/rpm docker-base/fedora-latest/

local-deb-install-libjwt:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt-get install -y autoconf automake libtool libssl-dev; \
	fi
	@if [ "$(LOCAL_INSTALL_LIBJWT)" = "1" ]; then \
		# install libjwt \
		wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O build/v${LIBJWT_VERSION}.tar.gz && \
		tar -xf build/v${LIBJWT_VERSION}.tar.gz -C build/; \
		( cd build/libjwt-${LIBJWT_VERSION}/ && \
		autoreconf -i && \
		(./configure --without-openssl || ./configure) && \
		make && \
		sudo make install ); \
	fi

orcania-deb:
	docker build -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/deb/
	docker run --rm -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-tgz:
	docker build -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/tgz/
	docker run --rm -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-rpm:
	docker build -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/rpm/
	docker run --rm -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) orcania-deb; \
		xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%; \
	fi

orcania-alpine: 
	$(MAKE) alpine
	$(MAKE) orcania-tgz
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-fedora: 
	$(MAKE) fedora
	$(MAKE) orcania-rpm
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev pkg-config; \
	fi

orcania-local-deb: orcania-install-dependencies
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package && \
	cp liborcania-dev_*.deb ../../../orcania/liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	rm -rf build/*
	echo liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./orcania/packages
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-build:
	$(MAKE) orcania-debian-stable
	$(MAKE) orcania-debian-testing
	$(MAKE) orcania-ubuntu-latest
	$(MAKE) orcania-ubuntu-lts
	$(MAKE) orcania-alpine
	$(MAKE) orcania-fedora

orcania-clean: clean-base
	rm -f orcania/*.tar.gz orcania/*.deb orcania/*.rpm orcania/packages
	-docker rmi -f babelouest/orcania

yder-deb:
	docker build -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/deb/
	docker run --rm -v $(shell pwd)/yder/:/share babelouest/yder

yder-tgz:
	docker build -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/tgz/
	docker run --rm -v $(shell pwd)/yder/:/share babelouest/yder

yder-rpm:
	docker build -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/rpm/
	docker run --rm -v $(shell pwd)/yder/:/share babelouest/yder

yder-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) yder-deb; \
		xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%; \
	fi

yder-alpine: 
	$(MAKE) alpine
	$(MAKE) yder-tgz
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-fedora: 
	$(MAKE) fedora
	$(MAKE) yder-rpm
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev libsystemd-dev pkg-config; \
	fi

yder-local-deb: yder-install-dependencies
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp libyder-dev_*.deb ../../../yder/libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	rm -rf build/*
	echo libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./yder/packages
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-build:
	$(MAKE) yder-debian-stable
	$(MAKE) yder-debian-testing
	$(MAKE) yder-ubuntu-latest
	$(MAKE) yder-ubuntu-lts
	$(MAKE) yder-alpine
	$(MAKE) yder-fedora

yder-clean: clean-base
	rm -f yder/*.tar.gz yder/*.deb yder/*.rpm yder/packages
	-docker rmi -f babelouest/yder

ulfius-deb:
	docker build -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/deb/
	docker run --rm -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-tgz:
	docker build -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/tgz/
	docker run --rm -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-rpm:
	docker build -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/rpm/
	docker run --rm -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) ulfius-deb; \
		xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%; \
	fi

ulfius-alpine: 
	$(MAKE) alpine
	$(MAKE) ulfius-tgz
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-fedora: 
	$(MAKE) fedora
	$(MAKE) ulfius-rpm
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev libsystemd-dev libsystemd-dev libgnutls28-dev libmicrohttpd-dev libgnutls28-dev pkg-config; \
	fi

ulfius-local-deb:
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp liborcania-dev_*.deb ../../../ulfius/liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp libyder-dev_*.deb ../../../ulfius/libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf build/v$(ULFIUS_VERSION).tar.gz -C build/
	rm -f build/v$(ULFIUS_VERSION).tar.gz
	( cd build/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make package; \
	cp libulfius-dev_*.deb ../../../ulfius/libulfius-dev_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd ulfius && tar cvz liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius-dev_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f ulfius-dev-full_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo libulfius-dev_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./ulfius/packages
	echo ulfius-dev-full_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./ulfius/packages
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-build:
	$(MAKE) ulfius-debian-stable
	$(MAKE) ulfius-debian-testing
	$(MAKE) ulfius-ubuntu-latest
	$(MAKE) ulfius-ubuntu-lts
	$(MAKE) ulfius-alpine
	$(MAKE) ulfius-fedora

ulfius-clean: clean-base
	rm -f ulfius/*.tar.gz ulfius/*.deb ulfius/*.rpm ulfius/packages
	-docker rmi -f babelouest/ulfius

hoel-deb:
	docker build -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/deb/
	docker run --rm -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-tgz:
	docker build -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/tgz/
	docker run --rm -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-rpm:
	docker build -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/rpm/
	docker run --rm -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hoel-deb; \
		xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%; \
	fi

hoel-alpine: 
	$(MAKE) alpine
	$(MAKE) hoel-tgz
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-fedora: 
	$(MAKE) fedora
	$(MAKE) hoel-rpm
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libpq-dev pkg-config; \
	fi

hoel-local-deb: hoel-install-dependencies
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp liborcania-dev_*.deb ../../../hoel/liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp libyder-dev_*.deb ../../../hoel/libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf build/v$(HOEL_VERSION).tar.gz -C build/
	rm -f build/v$(HOEL_VERSION).tar.gz
	( cd build/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make package; \
	cp libhoel-dev_*.deb ../../../hoel/libhoel-dev_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd hoel && tar cvz liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel-dev_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f hoel-dev-full_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo libhoel-dev_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./hoel/packages
	echo hoel-dev-full_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./hoel/packages
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-build:
	$(MAKE) hoel-debian-stable
	$(MAKE) hoel-debian-testing
	$(MAKE) hoel-ubuntu-latest
	$(MAKE) hoel-ubuntu-lts
	$(MAKE) hoel-alpine
	$(MAKE) hoel-fedora

hoel-clean: clean-base
	rm -f hoel/*.tar.gz hoel/*.deb hoel/*.rpm hoel/packages
	-docker rmi -f babelouest/hoel

glewlwyd-deb:
	docker build -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) glewlwyd/deb/
	docker run --rm -v $(shell pwd)/glewlwyd/:/share babelouest/glewlwyd

glewlwyd-tgz:
	docker build -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) glewlwyd/tgz/
	docker run --rm -v $(shell pwd)/glewlwyd/:/share babelouest/glewlwyd

glewlwyd-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) glewlwyd-deb; \
		xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%; \
	fi

glewlwyd-alpine: 
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libmicrohttpd-dev libjansson-dev libsystemd-dev uuid-dev libldap2-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libgnutls28-dev libcurl4-gnutls-dev libssl-dev pkg-config; \
	fi

glewlwyd-local-deb: glewlwyd-install-dependencies local-deb-install-libjwt
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../glewlwyd/liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../glewlwyd/libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf build/v$(ULFIUS_VERSION).tar.gz -C build/
	rm -f build/v$(ULFIUS_VERSION).tar.gz
	( cd build/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_WEBSOCKET=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_WEBSOCKET=off -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../glewlwyd/libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf build/v$(HOEL_VERSION).tar.gz -C build/
	rm -f build/v$(HOEL_VERSION).tar.gz
	( cd build/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../glewlwyd/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package glewlwyd
	wget https://github.com/babelouest/glewlwyd/archive/v$(GLEWLWYD_VERSION).tar.gz -O build/v$(GLEWLWYD_VERSION).tar.gz
	tar xf build/v$(GLEWLWYD_VERSION).tar.gz -C build/
	rm -f build/v$(GLEWLWYD_VERSION).tar.gz
	( cd build/glewlwyd-$(GLEWLWYD_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp glewlwyd_*.deb ../../../glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd glewlwyd && tar cvz liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb glewlwyd_$(GLEWLWYD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f glewlwyd-full_$(GLEWLWYD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo glewlwyd_$(GLEWLWYD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./glewlwyd/packages
	echo glewlwyd-full_$(GLEWLWYD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./glewlwyd/packages
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-build:
	$(MAKE) glewlwyd-debian-stable
	$(MAKE) glewlwyd-debian-testing
	$(MAKE) glewlwyd-ubuntu-latest
	$(MAKE) glewlwyd-ubuntu-lts
	$(MAKE) glewlwyd-alpine

glewlwyd-clean: clean-base
	rm -f glewlwyd/*.tar.gz glewlwyd/*.deb glewlwyd/packages
	-docker rmi -f babelouest/glewlwyd

taliesin-deb:
	docker build -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) taliesin/deb/
	docker run --rm -v $(shell pwd)/taliesin/:/share babelouest/taliesin

taliesin-tgz:
	docker build -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) taliesin/tgz/
	docker run --rm -v $(shell pwd)/taliesin/:/share babelouest/taliesin

taliesin-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) taliesin-deb
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) taliesin-deb
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) taliesin-deb
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) taliesin-deb; \
		xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%; \
	fi

taliesin-alpine: 
	$(MAKE) alpine
	$(MAKE) taliesin-tgz
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libconfig-dev libjansson-dev libsystemd-dev libgnutls28-dev libssl-dev libmicrohttpd-dev libmariadbclient-dev libsqlite3-dev libtool libavfilter-dev libavcodec-dev libavformat-dev libswresample-dev libavutil-dev pkg-config; \
	fi

taliesin-local-deb: taliesin-install-dependencies local-deb-install-libjwt
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../taliesin/liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../taliesin/libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf build/v$(ULFIUS_VERSION).tar.gz -C build/
	rm -f build/v$(ULFIUS_VERSION).tar.gz
	( cd build/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../taliesin/libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf build/v$(HOEL_VERSION).tar.gz -C build/
	rm -f build/v$(HOEL_VERSION).tar.gz
	( cd build/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../taliesin/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package taliesin
	wget https://github.com/babelouest/taliesin/archive/v$(TALIESIN_VERSION).tar.gz -O build/v$(TALIESIN_VERSION).tar.gz
	tar xf build/v$(TALIESIN_VERSION).tar.gz -C build/
	rm -f build/v$(TALIESIN_VERSION).tar.gz
	( cd build/taliesin-$(TALIESIN_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp taliesin_*.deb ../../../taliesin/taliesin_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd taliesin && tar cvz liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb taliesin_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f taliesin-full_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo taliesin_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./taliesin/packages
	echo taliesin-full_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./taliesin/packages
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-build:
	$(MAKE) taliesin-debian-stable
	$(MAKE) taliesin-debian-testing
	$(MAKE) taliesin-ubuntu-latest
	$(MAKE) taliesin-ubuntu-lts
	$(MAKE) taliesin-alpine

taliesin-clean: clean-base
	rm -f taliesin/*.tar.gz taliesin/*.deb taliesin/packages
	-docker rmi -f babelouest/taliesin

taliesin-quickstart-src:
	cd taliesin/quickstart && $(MAKE) build-quickstart-src TALIESIN_VERSION=$(TALIESIN_VERSION) LIBJWT_VERSION=$(LIBJWT_VERSION)

taliesin-quickstart-custom:
	cd taliesin/quickstart && $(MAKE) build-quickstart-x86_64_custom TALIESIN_VERSION=$(TALIESIN_VERSION) LIBJWT_VERSION=$(LIBJWT_VERSION)

taliesin-quickstart-sqlite-noauth:
	cd taliesin/quickstart && $(MAKE) build-quickstart-x86_64_sqlite_noauth TALIESIN_VERSION=$(TALIESIN_VERSION) LIBJWT_VERSION=$(LIBJWT_VERSION)

hutch-deb:
	docker build -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) hutch/deb/
	docker run --rm -v $(shell pwd)/hutch/:/share babelouest/hutch

hutch-tgz:
	docker build -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) hutch/tgz/
	docker run --rm -v $(shell pwd)/hutch/:/share babelouest/hutch

hutch-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hutch-deb; \
		xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%; \
	fi

hutch-alpine: 
	$(MAKE) alpine
	$(MAKE) hutch-tgz
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libmicrohttpd-dev libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libgnutls28-dev pkg-config; \
	fi

hutch-local-deb: hutch-install-dependencies local-deb-install-libjwt
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../hutch/liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../hutch/libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf build/v$(ULFIUS_VERSION).tar.gz -C build/
	rm -f build/v$(ULFIUS_VERSION).tar.gz
	( cd build/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_WEBSOCKET=off -DWITH_CURL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_WEBSOCKET=off -DWITH_CURL=off -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../hutch/libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf build/v$(HOEL_VERSION).tar.gz -C build/
	rm -f build/v$(HOEL_VERSION).tar.gz
	( cd build/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../hutch/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package hutch
	wget https://github.com/babelouest/hutch/archive/v$(HUTCH_VERSION).tar.gz -O build/v$(HUTCH_VERSION).tar.gz
	tar xf build/v$(HUTCH_VERSION).tar.gz -C build/
	rm -f build/v$(HUTCH_VERSION).tar.gz
	( cd build/hutch-$(HUTCH_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp hutch_*.deb ../../../hutch/hutch_$(HUTCH_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd hutch && tar cvz liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb hutch_$(HUTCH_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f hutch-full_$(HUTCH_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo hutch_$(HUTCH_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./hutch/packages
	echo hutch-full_$(HUTCH_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./hutch/packages
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-build:
	$(MAKE) hutch-debian-stable
	$(MAKE) hutch-debian-testing
	$(MAKE) hutch-ubuntu-latest
	$(MAKE) hutch-ubuntu-lts
	$(MAKE) hutch-alpine

hutch-clean: clean-base
	rm -f hutch/*.tar.gz hutch/*.deb hutch/packages
	-docker rmi -f babelouest/hutch

angharad-deb:
	docker build -t babelouest/angharad --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg ANGHARAD_VERSION=$(ANGHARAD_VERSION) --build-arg BENOIC_VERSION=$(BENOIC_VERSION) --build-arg CARLEON_VERSION=$(CARLEON_VERSION) --build-arg GARETH_VERSION=$(GARETH_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) angharad/deb/
	docker run --rm -v $(shell pwd)/angharad/:/share babelouest/angharad

angharad-tgz:
	docker build -t babelouest/angharad --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg ANGHARAD_VERSION=$(ANGHARAD_VERSION) --build-arg BENOIC_VERSION=$(BENOIC_VERSION) --build-arg CARLEON_VERSION=$(CARLEON_VERSION) --build-arg GARETH_VERSION=$(GARETH_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) angharad/tgz/
	docker run --rm -v $(shell pwd)/angharad/:/share babelouest/angharad

angharad-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) angharad-deb
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) angharad-deb
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) angharad-deb
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-ubuntu-lts: 
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) angharad-deb; \
		xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%; \
	fi

angharad-alpine: 
	$(MAKE) alpine
	$(MAKE) angharad-tgz
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libmicrohttpd-dev libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libopenzwave1.5-dev libmpdclient-dev libcurl4-gnutls-dev g++ pkg-config; \
	fi

angharad-local-deb: angharad-install-dependencies local-deb-install-libjwt
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf build/v$(ORCANIA_VERSION).tar.gz -C build/
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../angharad/liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf build/v$(YDER_VERSION).tar.gz -C build/
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../angharad/libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf build/v$(ULFIUS_VERSION).tar.gz -C build/
	rm -f build/v$(ULFIUS_VERSION).tar.gz
	( cd build/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_WEBSOCKET=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_WEBSOCKET=off -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../angharad/libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf build/v$(HOEL_VERSION).tar.gz -C build/
	rm -f build/v$(HOEL_VERSION).tar.gz
	( cd build/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../angharad/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package angharad
	wget https://github.com/babelouest/angharad/archive/v$(ANGHARAD_VERSION).tar.gz -O build/v$(ANGHARAD_VERSION).tar.gz
	tar -xvf build/v$(ANGHARAD_VERSION).tar.gz -C build/
	rm build/v$(ANGHARAD_VERSION).tar.gz
	wget https://github.com/babelouest/benoic/archive/v$(BENOIC_VERSION).tar.gz -O build/v$(BENOIC_VERSION).tar.gz
	tar -xvf build/v$(BENOIC_VERSION).tar.gz -C build/
	rm build/v$(BENOIC_VERSION).tar.gz
	wget https://github.com/babelouest/carleon/archive/v$(CARLEON_VERSION).tar.gz -O build/v$(CARLEON_VERSION).tar.gz
	tar -xvf build/v$(CARLEON_VERSION).tar.gz -C build/
	rm build/v$(CARLEON_VERSION).tar.gz
	wget https://github.com/babelouest/gareth/archive/v$(GARETH_VERSION).tar.gz -O build/v$(GARETH_VERSION).tar.gz
	tar -xvf build/v$(GARETH_VERSION).tar.gz -C build/
	rm build/v$(GARETH_VERSION).tar.gz
	mv build/benoic-$(BENOIC_VERSION)/* build/angharad-$(ANGHARAD_VERSION)/src/benoic/
	mv build/carleon-$(CARLEON_VERSION)/* build/angharad-$(ANGHARAD_VERSION)/src/carleon/
	mv build/gareth-$(GARETH_VERSION)/* build/angharad-$(ANGHARAD_VERSION)/src/gareth/
	(cd build/angharad-$(ANGHARAD_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp angharad_*.deb ../../../angharad/angharad_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd angharad && tar cvz liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb angharad_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f angharad-full_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo angharad_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./angharad/packages
	echo angharad-full_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./angharad/packages
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-build:
	$(MAKE) angharad-debian-stable
	$(MAKE) angharad-debian-testing
	$(MAKE) angharad-ubuntu-latest
	$(MAKE) angharad-ubuntu-lts
	$(MAKE) angharad-alpine

angharad-clean: clean-base
	rm -f angharad/*.tar.gz angharad/*.deb angharad/packages
	-docker rmi -f babelouest/angharad
