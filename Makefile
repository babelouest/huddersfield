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
GITHUB_USER=babelouest
GITHUB_TOKEN=$(shell cat GITHUB_TOKEN)

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
LIBJWT_VERSION=1.9.0

CODE_DEBIAN_STABLE=stretch
CODE_DEBIAN_TESTING=buster
CODE_UBUNTU_LATEST=artful
CODE_UBUNTU_LTS=xenial
CODE_ALPINE_STABLE=3.7
CODE_RASPBIAN_STABLE=stretch

all: build-debian-stable build-debian-testing build-ubuntu-latest build-ubuntu-lts build-alpine

build-debian-stable: orcania-debian-stable yder-debian-stable ulfius-debian-stable hoel-debian-stable glewlwyd-debian-stable taliesin-debian-stable hutch-debian-stable

build-debian-testing: orcania-debian-testing yder-debian-testing ulfius-debian-testing hoel-debian-testing glewlwyd-debian-testing taliesin-debian-testing hutch-debian-testing

build-ubuntu-latest: orcania-ubuntu-latest yder-ubuntu-latest ulfius-ubuntu-latest hoel-ubuntu-latest glewlwyd-ubuntu-latest taliesin-ubuntu-latest hutch-ubuntu-latest

build-ubuntu-lts: orcania-ubuntu-lts yder-ubuntu-lts ulfius-ubuntu-lts hoel-ubuntu-lts glewlwyd-ubuntu-lts hutch-ubuntu-lts

build-alpine: orcania-alpine yder-alpine ulfius-alpine hoel-alpine glewlwyd-alpine taliesin-alpine hutch-alpine

build-raspbian: orcania-raspbian yder-raspbian ulfius-raspbian hoel-raspbian glewlwyd-raspbian taliesin-raspbian hutch-raspbian

upload-asset:
	@if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
		for CUR_FILE in $(PATTERN); do \
			./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=$(REPO) tag=v$(TAG) filename=$$CUR_FILE; \
		done; \
	fi

clean-base:
	-docker rmi -f babelouest/deb babelouest/tgz

clean: orcania-clean yder-clean ulfius-clean hoel-clean glewlwyd-clean taliesin-clean hutch-clean clean-base clean-no-tag-images

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

orcania-deb:
	docker build -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) orcania/deb/
	docker run --rm -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-tgz:
	docker build -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) orcania/tgz/
	docker run --rm -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) orcania-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/liborcania-dev_$(ORCANIA_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb

orcania-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) orcania-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/liborcania-dev_$(ORCANIA_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb

orcania-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) orcania-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/liborcania-dev_$(ORCANIA_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb

orcania-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) orcania-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/liborcania-dev_$(ORCANIA_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.deb

orcania-alpine: 
	$(MAKE) alpine
	$(MAKE) orcania-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/liborcania-dev_$(ORCANIA_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

orcania-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install libjansson-dev
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp liborcania-dev_*.deb ../../../orcania/liborcania-dev_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )
	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/liborcania-dev_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb

orcania-build:
	$(MAKE) orcania-debian-stable
	$(MAKE) orcania-debian-testing
	$(MAKE) orcania-ubuntu-latest
	$(MAKE) orcania-ubuntu-lts
	$(MAKE) orcania-alpine

orcania-clean: clean-base
	rm -f orcania/*.tar.gz orcania/*.deb
	-docker rmi -f babelouest/orcania

yder-deb:
	docker build -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) yder/deb/
	docker run --rm -v $(shell pwd)/yder/:/share babelouest/yder

yder-tgz:
	docker build -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) yder/tgz/
	docker run --rm -v $(shell pwd)/yder/:/share babelouest/yder

yder-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) yder-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/libyder-dev_$(YDER_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb

yder-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) yder-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/libyder-dev_$(YDER_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb

yder-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) yder-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/libyder-dev_$(YDER_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb

yder-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) yder-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/libyder-dev_$(YDER_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.deb

yder-alpine: 
	$(MAKE) alpine
	$(MAKE) yder-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/libyder-dev_$(YDER_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

yder-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install libjansson-dev
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ORCANIA_VERSION).tar.gz
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O raspbian/v$(YDER_VERSION).tar.gz
	tar xf raspbian/v$(YDER_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(YDER_VERSION).tar.gz
	( cd raspbian/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp libyder-dev_*.deb ../../../yder/libyder-dev_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/libyder-dev_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb

yder-build:
	$(MAKE) yder-debian-stable
	$(MAKE) yder-debian-testing
	$(MAKE) yder-ubuntu-latest
	$(MAKE) yder-ubuntu-lts
	$(MAKE) yder-alpine

yder-clean: clean-base
	rm -f yder/*.tar.gz yder/*.deb
	-docker rmi -f babelouest/yder

ulfius-deb:
	docker build -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) ulfius/deb/
	docker run --rm -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-tgz:
	docker build -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) ulfius/tgz/
	docker run --rm -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) ulfius-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/libulfius-dev_$(ULFIUS_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/ulfius-dev-full_$(ULFIUS_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.tar.gz

ulfius-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) ulfius-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/libulfius-dev_$(ULFIUS_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/ulfius-dev-full_$(ULFIUS_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.tar.gz

ulfius-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) ulfius-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/libulfius-dev_$(ULFIUS_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/ulfius-dev-full_$(ULFIUS_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.tar.gz

ulfius-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) ulfius-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/libulfius-dev_$(ULFIUS_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/ulfius-dev-full_$(ULFIUS_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.tar.gz

ulfius-alpine: 
	$(MAKE) alpine
	$(MAKE) ulfius-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/libulfius-dev_$(ULFIUS_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/ulfius-dev-full_$(ULFIUS_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

ulfius-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install libjansson-dev libmariadbclient-dev libsqlite3-dev libpq-dev
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ORCANIA_VERSION).tar.gz
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp liborcania-dev_*.deb ../../../ulfius/liborcania-dev_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O raspbian/v$(YDER_VERSION).tar.gz
	tar xf raspbian/v$(YDER_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(YDER_VERSION).tar.gz
	( cd raspbian/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp libyder-dev_*.deb ../../../ulfius/libyder-dev_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O raspbian/v$(ULFIUS_VERSION).tar.gz
	tar xf raspbian/v$(ULFIUS_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ULFIUS_VERSION).tar.gz
	( cd raspbian/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make package; \
	cp libulfius-dev_*.deb ../../../ulfius/libulfius-dev_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	( cd ulfius && tar cvz liborcania-dev_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libyder-dev_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libulfius-dev_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb -f ulfius-full_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.tar.gz )
	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/libulfius-dev_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/ulfius-full_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.tar.gz

ulfius-build:
	$(MAKE) ulfius-debian-stable
	$(MAKE) ulfius-debian-testing
	$(MAKE) ulfius-ubuntu-latest
	$(MAKE) ulfius-ubuntu-lts
	$(MAKE) ulfius-alpine

ulfius-clean: clean-base
	rm -f ulfius/*.tar.gz ulfius/*.deb
	-docker rmi -f babelouest/ulfius

hoel-deb:
	docker build -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) hoel/deb/
	docker run --rm -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-tgz:
	docker build -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) hoel/tgz/
	docker run --rm -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) hoel-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/libhoel-dev_$(HOEL_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/hoel-dev-full_$(HOEL_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.tar.gz

hoel-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) hoel-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/libhoel-dev_$(HOEL_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/hoel-dev-full_$(HOEL_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.tar.gz

hoel-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) hoel-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/libhoel-dev_$(HOEL_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/hoel-dev-full_$(HOEL_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.tar.gz

hoel-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) hoel-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/libhoel-dev_$(HOEL_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/hoel-dev-full_$(HOEL_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.tar.gz

hoel-alpine: 
	$(MAKE) alpine
	$(MAKE) hoel-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/libhoel-dev_$(HOEL_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/hoel-dev-full_$(HOEL_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

hoel-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install libjansson-dev libmariadbclient-dev libsqlite3-dev libpq-dev
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ORCANIA_VERSION).tar.gz
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp liborcania-dev_*.deb ../../../hoel/liborcania-dev_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O raspbian/v$(YDER_VERSION).tar.gz
	tar xf raspbian/v$(YDER_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(YDER_VERSION).tar.gz
	( cd raspbian/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	sudo make install && \
	cp libyder-dev_*.deb ../../../hoel/libyder-dev_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O raspbian/v$(HOEL_VERSION).tar.gz
	tar xf raspbian/v$(HOEL_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(HOEL_VERSION).tar.gz
	( cd raspbian/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make package; \
	cp libhoel-dev_*.deb ../../../hoel/libhoel-dev_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	( cd hoel && tar cvz liborcania-dev_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libyder-dev_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libhoel-dev_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb -f hoel-full_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.tar.gz )
	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/libhoel-dev_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/hoel-full_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.tar.gz

hoel-build:
	$(MAKE) hoel-debian-stable
	$(MAKE) hoel-debian-testing
	$(MAKE) hoel-ubuntu-latest
	$(MAKE) hoel-ubuntu-lts
	$(MAKE) hoel-alpine

hoel-clean: clean-base
	rm -f hoel/*.tar.gz hoel/*.deb
	-docker rmi -f babelouest/hoel

glewlwyd-deb:
	docker build -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) glewlwyd/deb/
	docker run --rm -v $(shell pwd)/glewlwyd/:/share babelouest/glewlwyd

glewlwyd-tgz:
	docker build -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) glewlwyd/tgz/
	docker run --rm -v $(shell pwd)/glewlwyd/:/share babelouest/glewlwyd

glewlwyd-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd-full_$(GLEWLWYD_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.tar.gz

glewlwyd-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd-full_$(GLEWLWYD_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.tar.gz

glewlwyd-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd-full_$(GLEWLWYD_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.tar.gz

glewlwyd-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) glewlwyd-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd-full_$(GLEWLWYD_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.tar.gz

glewlwyd-alpine: 
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd-full_$(GLEWLWYD_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

glewlwyd-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install libmicrohttpd-dev libjansson-dev libcurl4-gnutls-dev uuid-dev libldap2-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libgnutls28-dev libssl-dev
	
	# install libjwt
	wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O raspbian/v${LIBJWT_VERSION}.tar.gz && \
	tar -xf raspbian/v${LIBJWT_VERSION}.tar.gz -C raspbian/
	(cd raspbian/libjwt-${LIBJWT_VERSION}/ && \
	autoreconf -i && \
	(./configure --without-openssl || ./configure) && \
	make && \
	sudo make install )
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ORCANIA_VERSION).tar.gz
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../glewlwyd/liborcania_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O raspbian/v$(YDER_VERSION).tar.gz
	tar xf raspbian/v$(YDER_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(YDER_VERSION).tar.gz
	( cd raspbian/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../glewlwyd/libyder_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O raspbian/v$(ULFIUS_VERSION).tar.gz
	tar xf raspbian/v$(ULFIUS_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ULFIUS_VERSION).tar.gz
	( cd raspbian/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_WEBSOCKET=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_WEBSOCKET=off -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../glewlwyd/libulfius_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O raspbian/v$(HOEL_VERSION).tar.gz
	tar xf raspbian/v$(HOEL_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(HOEL_VERSION).tar.gz
	( cd raspbian/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../glewlwyd/libhoel_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package glewlwyd
	wget https://github.com/babelouest/glewlwyd/archive/v$(GLEWLWYD_VERSION).tar.gz -O raspbian/v$(GLEWLWYD_VERSION).tar.gz
	tar xf raspbian/v$(GLEWLWYD_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(GLEWLWYD_VERSION).tar.gz
	( cd raspbian/glewlwyd-$(GLEWLWYD_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp glewlwyd_*.deb ../../../glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	( cd glewlwyd && tar cvz liborcania_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libyder_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb glewlwyd_$(GLEWLWYD_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb -f glewlwyd-full_$(GLEWLWYD_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.tar.gz )
	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd_$(GLEWLWYD_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/glewlwyd-full_$(GLEWLWYD_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.tar.gz

glewlwyd-build:
	$(MAKE) glewlwyd-debian-stable
	$(MAKE) glewlwyd-debian-testing
	$(MAKE) glewlwyd-ubuntu-latest
	$(MAKE) glewlwyd-ubuntu-lts
	$(MAKE) glewlwyd-alpine

glewlwyd-clean: clean-base
	rm -f glewlwyd/*.tar.gz glewlwyd/*.deb
	-docker rmi -f babelouest/glewlwyd

taliesin-deb:
	docker build -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) taliesin/deb/
	docker run --rm -v $(shell pwd)/taliesin/:/share babelouest/taliesin

taliesin-tgz:
	docker build -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) taliesin/tgz/
	docker run --rm -v $(shell pwd)/taliesin/:/share babelouest/taliesin

taliesin-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) taliesin-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin_$(TALIESIN_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin-full_$(TALIESIN_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.tar.gz

taliesin-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) taliesin-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin_$(TALIESIN_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin-full_$(TALIESIN_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.tar.gz

taliesin-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) taliesin-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin_$(TALIESIN_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin-full_$(TALIESIN_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.tar.gz

taliesin-alpine: 
	$(MAKE) alpine
	$(MAKE) taliesin-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin_$(TALIESIN_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin-full_$(TALIESIN_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

taliesin-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install autoconf libconfig-dev libjansson-dev libgnutls28-dev libssl-dev libmicrohttpd-dev libsqlite3-dev libtool libavfilter-dev libavcodec-dev libavformat-dev libavresample-dev libavutil-dev

	# install libjwt
	wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O raspbian/v${LIBJWT_VERSION}.tar.gz && \
	tar -xf raspbian/v${LIBJWT_VERSION}.tar.gz -C raspbian/
	(cd raspbian/libjwt-${LIBJWT_VERSION}/ && \
	autoreconf -i && \
	(./configure --without-openssl || ./configure) && \
	make && \
	sudo make install )
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ORCANIA_VERSION).tar.gz
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../taliesin/liborcania_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O raspbian/v$(YDER_VERSION).tar.gz
	tar xf raspbian/v$(YDER_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(YDER_VERSION).tar.gz
	( cd raspbian/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../taliesin/libyder_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O raspbian/v$(ULFIUS_VERSION).tar.gz
	tar xf raspbian/v$(ULFIUS_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ULFIUS_VERSION).tar.gz
	( cd raspbian/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_WEBSOCKET=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_WEBSOCKET=off -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../taliesin/libulfius_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O raspbian/v$(HOEL_VERSION).tar.gz
	tar xf raspbian/v$(HOEL_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(HOEL_VERSION).tar.gz
	( cd raspbian/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../taliesin/libhoel_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package taliesin
	wget https://github.com/babelouest/taliesin/archive/v$(TALIESIN_VERSION).tar.gz -O raspbian/v$(TALIESIN_VERSION).tar.gz
	tar xf raspbian/v$(TALIESIN_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(TALIESIN_VERSION).tar.gz
	( cd raspbian/taliesin-$(TALIESIN_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp taliesin_*.deb ../../../taliesin/taliesin_$(TALIESIN_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	( cd taliesin && tar cvz liborcania_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libyder_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb taliesin_$(TALIESIN_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb -f taliesin-full_$(TALIESIN_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.tar.gz )
	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin_$(TALIESIN_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/taliesin-full_$(TALIESIN_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.tar.gz

taliesin-build:
	$(MAKE) taliesin-debian-stable
	$(MAKE) taliesin-debian-testing
	$(MAKE) taliesin-ubuntu-latest
	$(MAKE) taliesin-alpine

taliesin-clean: clean-base
	rm -f taliesin/*.tar.gz taliesin/*.deb
	-docker rmi -f babelouest/taliesin

taliesin-quickstart-src:
	cd taliesin/quickstart && $(MAKE) build-quickstart-src TALIESIN_VERSION=$(TALIESIN_VERSION) LIBJWT_VERSION=$(LIBJWT_VERSION)

taliesin-quickstart-custom:
	cd taliesin/quickstart && $(MAKE) build-quickstart-x86_64_custom TALIESIN_VERSION=$(TALIESIN_VERSION) LIBJWT_VERSION=$(LIBJWT_VERSION)

taliesin-quickstart-sqlite-noauth:
	cd taliesin/quickstart && $(MAKE) build-quickstart-x86_64_sqlite_noauth TALIESIN_VERSION=$(TALIESIN_VERSION) LIBJWT_VERSION=$(LIBJWT_VERSION)

hutch-deb:
	docker build -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) hutch/deb/
	docker run --rm -v $(shell pwd)/hutch/:/share babelouest/hutch

hutch-tgz:
	docker build -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) hutch/tgz/
	docker run --rm -v $(shell pwd)/hutch/:/share babelouest/hutch

hutch-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) hutch-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch_$(HUTCH_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch-full_$(HUTCH_VERSION)_Debian_$(CODE_DEBIAN_STABLE)_*.tar.gz

hutch-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) hutch-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch_$(HUTCH_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch-full_$(HUTCH_VERSION)_Debian_$(CODE_DEBIAN_TESTING)_*.tar.gz

hutch-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) hutch-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch_$(HUTCH_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch-full_$(HUTCH_VERSION)_Ubuntu_$(CODE_UBUNTU_LATEST)_*.tar.gz

hutch-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) hutch-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch_$(HUTCH_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch-full_$(HUTCH_VERSION)_Ubuntu_$(CODE_UBUNTU_LTS)_*.tar.gz

hutch-alpine: 
	$(MAKE) alpine
	$(MAKE) hutch-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch_$(HUTCH_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch-full_$(HUTCH_VERSION)_Alpine_$(CODE_ALPINE_STABLE)_*.tar.gz

hutch-raspbian:
	# install dependencies
	sudo apt update && sudo apt upgrade -y
	sudo apt-get -y install autoconf libtool libmicrohttpd-dev libjansson-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libssl-dev
	
	# install libjwt
	wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz -O raspbian/v${LIBJWT_VERSION}.tar.gz && \
	tar -xf raspbian/v${LIBJWT_VERSION}.tar.gz -C raspbian/
	(cd raspbian/libjwt-${LIBJWT_VERSION}/ && \
	autoreconf -i && \
	./configure && \
	make && \
	sudo make install )
	
	# package orcania
	wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O raspbian/v$(ORCANIA_VERSION).tar.gz
	tar xf raspbian/v$(ORCANIA_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ORCANIA_VERSION).tar.gz
	( cd raspbian/orcania-$(ORCANIA_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp liborcania_*.deb ../../../hutch/liborcania_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package yder
	wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O raspbian/v$(YDER_VERSION).tar.gz
	tar xf raspbian/v$(YDER_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(YDER_VERSION).tar.gz
	( cd raspbian/yder-$(YDER_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libyder_*.deb ../../../hutch/libyder_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package ulfius
	wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O raspbian/v$(ULFIUS_VERSION).tar.gz
	tar xf raspbian/v$(ULFIUS_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(ULFIUS_VERSION).tar.gz
	( cd raspbian/ulfius-$(ULFIUS_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_WEBSOCKET=off -DWITH_CURL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_WEBSOCKET=off -DWITH_CURL=off -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../hutch/libulfius_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )
	
	# package hoel
	wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O raspbian/v$(HOEL_VERSION).tar.gz
	tar xf raspbian/v$(HOEL_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(HOEL_VERSION).tar.gz
	( cd raspbian/hoel-$(HOEL_VERSION) && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../hutch/libhoel_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	# package hutch
	wget https://github.com/babelouest/hutch/archive/v$(HUTCH_VERSION).tar.gz -O raspbian/v$(HUTCH_VERSION).tar.gz
	tar xf raspbian/v$(HUTCH_VERSION).tar.gz -C raspbian/
	rm -f raspbian/v$(HUTCH_VERSION).tar.gz
	( cd raspbian/hutch-$(HUTCH_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp hutch_*.deb ../../../hutch/hutch_$(HUTCH_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb )

	( cd hutch && tar cvz liborcania_$(ORCANIA_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libyder_$(YDER_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb hutch_$(HUTCH_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.deb -f hutch-full_$(HUTCH_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_`uname -m`.tar.gz )
	rm -rf raspbian/*
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch_$(HUTCH_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.deb
	$(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/hutch-full_$(HUTCH_VERSION)_Raspbian_$(CODE_RASPBIAN_STABLE)_*.tar.gz

hutch-build:
	$(MAKE) hutch-debian-stable
	$(MAKE) hutch-debian-testing
	$(MAKE) hutch-ubuntu-latest
	$(MAKE) hutch-ubuntu-lts
	$(MAKE) hutch-alpine

hutch-clean: clean-base
	rm -f hutch/*.tar.gz hutch/*.deb
	-docker rmi -f babelouest/hutch
