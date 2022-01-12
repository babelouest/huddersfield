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
# Copyright 2018-2019 Nicolas Mora <mail@babelouest.org>
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
REMOTE=1
SIGN_ASSET=1
LOCAL_UPDATE_SYSTEM=0
GITHUB_USER=babelouest
GITHUB_TOKEN=$(shell cat GITHUB_TOKEN)
LOCAL_ID=$(shell grep -e "^ID=" /etc/os-release |cut -c 4-)
LOCAL_RELEASE=$(shell lsb_release -c -s)
DOCKER_BUILD=docker build
DOCKER_RUN=docker run

LIBJANSSON_VERSION=2.13.1
LIBCBOR_VERSION=0.9.0

ORCANIA_SRC=../orcania
YDER_SRC=../yder
HOEL_SRC=../hoel
ULFIUS_SRC=../ulfius
RHONABWY_SRC=../rhonabwy
IDDAWC_SRC=../iddawc
GLEWLWYD_SRC=../glewlwyd
ANGHARAD_SRC=../angharad
HUTCH_SRC=../hutch
TALIESIN_SRC=../taliesin

ifeq (($(GITHUB_TOKEN)),"")
	AUTH_HEADER=
else
	AUTH_HEADER=-H "Authorization: token $(GITHUB_TOKEN)"
endif

#ORCANIA_VERSION=$(shell grep "## " $(ORCANIA_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#YDER_VERSION=$(shell grep "## " $(YDER_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#ULFIUS_VERSION=$(shell grep "## " $(ULFIUS_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#HOEL_VERSION=$(shell grep "## " $(HOEL_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#GLEWLWYD_VERSION=$(shell grep "## " $(GLEWLWYD_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#ANGHARAD_VERSION=$(shell grep "## " $(ANGHARAD_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#HUTCH_VERSION=$(shell grep "## " $(HUTCH_SRC)/CHANGELOG.md | head -1 | cut -c 4-)
#TALIESIN_VERSION=$(shell grep "## " $(TALIESIN_SRC)/CHANGELOG.md | head -1 | cut -c 4-)

#wget -O angharad/angharad.tar.gz https://github.com/babelouest/angharad/archive/v$(ANGHARAD_VERSION).tar.gz
#wget -O angharad/benoic.tar.gz https://github.com/babelouest/benoic/archive/v$(BENOIC_VERSION).tar.gz
#wget -O angharad/carleon.tar.gz https://github.com/babelouest/carleon/archive/v$(CARLEON_VERSION).tar.gz
#wget -O angharad/gareth.tar.gz https://github.com/babelouest/gareth/archive/v$(GARETH_VERSION).tar.gz
#(cd angharad && mkdir angharad && tar xf angharad.tar.gz -C angharad --strip 1 && cd angharad && mkdir benoic carleon gareth && \
#tar xf ../benoic.tar.gz -C benoic --strip 1 && tar xf ../carleon.tar.gz -C carleon --strip 1 && tar xf ../gareth.tar.gz -C gareth --strip 1 && \
#cd .. && rm angharad.tar.gz benoic.tar.gz carleon.tar.gz gareth.tar.gz && tar cz angharad -f angharad.tar.gz)

ORCANIA_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/orcania/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
YDER_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/yder/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
ULFIUS_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/ulfius/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
HOEL_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/hoel/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
RHONABWY_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/rhonabwy/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
IDDAWC_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/iddawc/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
GLEWLWYD_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/glewlwyd/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
TALIESIN_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/taliesin/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
HUTCH_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/hutch/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
ANGHARAD_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/angharad/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
BENOIC_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/benoic/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
CARLEON_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/carleon/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
GARETH_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/gareth/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)

all: debian-stable-build debian-testing-build ubuntu-latest-build ubuntu-lts-build alpine-build fedora-build

debian-oldstable-build: orcania-debian-oldstable yder-debian-oldstable ulfius-debian-oldstable hoel-debian-oldstable rhonabwy-debian-oldstable iddawc-debian-oldstable glewlwyd-debian-oldstable taliesin-debian-oldstable angharad-debian-oldstable hutch-debian-oldstable

debian-stable-build: orcania-debian-stable yder-debian-stable ulfius-debian-stable hoel-debian-stable rhonabwy-debian-stable iddawc-debian-stable glewlwyd-debian-stable taliesin-debian-stable angharad-debian-stable hutch-debian-stable

debian-testing-build: orcania-debian-testing yder-debian-testing ulfius-debian-testing hoel-debian-testing rhonabwy-debian-testing iddawc-debian-testing glewlwyd-debian-testing taliesin-debian-testing hutch-debian-testing angharad-debian-testing

ubuntu-latest-build: orcania-ubuntu-latest yder-ubuntu-latest ulfius-ubuntu-latest hoel-ubuntu-latest rhonabwy-ubuntu-latest iddawc-ubuntu-latest glewlwyd-ubuntu-latest taliesin-ubuntu-latest hutch-ubuntu-latest angharad-ubuntu-latest

ubuntu-lts-build: orcania-ubuntu-lts yder-ubuntu-lts ulfius-ubuntu-lts hoel-ubuntu-lts rhonabwy-ubuntu-lts iddawc-ubuntu-lts glewlwyd-ubuntu-lts taliesin-ubuntu-lts hutch-ubuntu-lts angharad-ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" = "$(shell docker images -q ubuntu:rolling)" ]; then \
		echo "Current Ubuntu LTS release is the same than latest release, ignore ubuntu-lts-build target"; \
	fi

alpine-build: orcania-alpine yder-alpine ulfius-alpine hoel-alpine rhonabwy-alpine iddawc-alpine glewlwyd-alpine taliesin-alpine hutch-alpine angharad-alpine

fedora-build: orcania-fedora yder-fedora ulfius-fedora hoel-fedora rhonabwy-fedora iddawc-fedora glewlwyd-fedora

centos-build: orcania-centos yder-centos ulfius-centos hoel-centos rhonabwy-centos iddawc-centos glewlwyd-centos

rocky-build: orcania-rocky yder-rocky ulfius-rocky hoel-rocky rhonabwy-rocky iddawc-rocky glewlwyd-rocky

local-build-deb: orcania-local-deb yder-local-deb ulfius-local-deb hoel-local-deb rhonabwy-local-deb iddawc-local-deb glewlwyd-local-deb taliesin-local-deb hutch-local-deb angharad-local-deb

upload-asset:
	@for CUR_FILE in $(PATTERN); do \
		if [ "$(SIGN_ASSET)" = "1" ]; then \
			gpg --detach-sign --yes $$CUR_FILE || true; \
		fi; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f $$CUR_FILE.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=$(REPO) tag=v$(TAG) filename=$$CUR_FILE.sig; \
			fi; \
			./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=$(REPO) tag=v$(TAG) filename=$$CUR_FILE; \
		fi \
	done;

clean-base:
	-docker rmi -f babelouest/deb babelouest/tgz babelouest/rpm
	/bin/rm -rf build/*

clean: orcania-clean yder-clean ulfius-clean hoel-clean rhonabwy-clean iddawc-clean glewlwyd-clean taliesin-clean hutch-clean angharad-clean clean-base clean-no-tag-images
	echo > summary.log

clean-no-tag-images:
	-docker system prune -f
#	-docker rmi -f $(shell docker images -f "dangling=true" -q)

debian-oldstable:
	@$(DOCKER_BUILD) -t babelouest/deb docker-base/debian-oldstable/

debian-stable:
	@$(DOCKER_BUILD) -t babelouest/deb docker-base/debian-stable/

debian-testing:
	$(DOCKER_BUILD) -t babelouest/deb docker-base/debian-testing/

ubuntu-latest:
	$(DOCKER_BUILD) -t babelouest/deb docker-base/ubuntu-latest/

ubuntu-lts:
	$(DOCKER_BUILD) -t babelouest/deb docker-base/ubuntu-lts/

alpine:
	$(DOCKER_BUILD) -t babelouest/tgz docker-base/alpine-current/

fedora:
	$(DOCKER_BUILD) -t babelouest/rpm docker-base/fedora-latest/

opensuse-tumbleweed:
	$(DOCKER_BUILD) -t babelouest/rpm docker-base/opensuse-tumbleweed/

opensuse-leap:
	$(DOCKER_BUILD) -t babelouest/rpm docker-base/opensuse-leap/

centos:
	$(DOCKER_BUILD) -t babelouest/rpm docker-base/centos-latest/

rocky:
	$(DOCKER_BUILD) -t babelouest/rpm docker-base/rocky-latest/

deb-shell:
	$(DOCKER_BUILD) -t babelouest/deb-shell --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) shell/deb/
	$(DOCKER_RUN) -p 8080:8080 --rm -it -v $(shell dirname "$$(pwd)")/:/share -v /media/:/media/ babelouest/deb-shell bash

tgz-shell:
	$(DOCKER_BUILD) -t babelouest/tgz-shell --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) shell/tgz/
	$(DOCKER_RUN) -p 8080:8080 --rm -it -v $(shell dirname "$$(pwd)")/:/share babelouest/tgz-shell bash

rpm-shell:
	$(DOCKER_BUILD) -t babelouest/rpm-shell --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) --build-arg RPMI=$(RPMI) shell/rpm/
	$(DOCKER_RUN) -p 8080:8080 --rm -it -v $(shell dirname "$$(pwd)")/:/share babelouest/rpm-shell

shell-debian-oldstable:
	$(MAKE) debian-oldstable
	$(MAKE) deb-shell

shell-debian-stable:
	$(MAKE) debian-stable
	$(MAKE) deb-shell

shell-debian-testing:
	$(MAKE) debian-testing
	$(MAKE) deb-shell

shell-ubuntu-latest:
	$(MAKE) ubuntu-latest
	$(MAKE) deb-shell

shell-ubuntu-lts:
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) deb-shell; \
	fi

shell-alpine:
	$(MAKE) alpine
	$(MAKE) tgz-shell

shell-fedora:
	$(MAKE) fedora
	$(MAKE) rpm-shell RPMI=yum

shell-centos:
	$(MAKE) centos
	$(MAKE) rpm-shell RPMI=yum

shell-rocky:
	$(MAKE) rocky
	$(MAKE) rpm-shell RPMI=yum

orcania-source: orcania/orcania.tar.gz

orcania-source-signed: orcania/orcania.tar.gz orcania/orcania.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes orcania/orcania.tar.gz || true; \
		gpg --detach-sign --yes orcania/orcania.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f orcania/orcania.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=orcania tag=v$(ORCANIA_VERSION) filename=orcania/orcania.tar.gz.sig; \
			fi; \
			if [ -f orcania/orcania.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=orcania tag=v$(ORCANIA_VERSION) filename=orcania/orcania.zip.sig; \
			fi; \
		fi \
	fi;

orcania/orcania.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O orcania/orcania.tar.gz https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz; \
	else \
		tar --exclude 'orcania/.git/*' -cvzf orcania/orcania.tar.gz $(ORCANIA_SRC); \
	fi

orcania/orcania.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O orcania/orcania.zip https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).zip; \
	fi

orcania-deb:
	$(DOCKER_BUILD) -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/orcania

orcania-deb-test:
	cp orcania/*.deb orcania/test/deb/
	$(DOCKER_BUILD) -t babelouest/orcania-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/test/deb/
	rm -f orcania/test/deb/*.deb
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/orcania-test

orcania-tgz:
	$(DOCKER_BUILD) -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/orcania

orcania-tgz-test:
	cp orcania/*.tar.gz orcania/test/tgz/
	$(DOCKER_BUILD) -t babelouest/orcania-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/test/tgz/
	rm -f orcania/test/tgz/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/orcania-test

orcania-rpm:
	$(DOCKER_BUILD) -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) orcania/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/orcania

orcania-rpm-test:
	cp orcania/*.rpm orcania/test/rpm/
	$(DOCKER_BUILD) -t babelouest/orcania-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg RPMI=$(RPMI) orcania/test/rpm/
	rm -f orcania/test/rpm/*.rpm
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/orcania-test

orcania-debian-oldstable: orcania-source
	$(MAKE) debian-oldstable
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-debian-stable: orcania-source
	$(MAKE) debian-stable
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-debian-oldstable-test: orcania-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) orcania-deb-test

orcania-debian-stable-test: orcania-debian-stable
	$(MAKE) debian-stable
	$(MAKE) orcania-deb-test

orcania-debian-testing: orcania-source
	$(MAKE) debian-testing
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-debian-testing-test: orcania-debian-testing
	$(MAKE) debian-testing
	$(MAKE) orcania-deb-test

orcania-ubuntu-latest: orcania-source
	$(MAKE) ubuntu-latest
	$(MAKE) orcania-deb
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-ubuntu-lts: orcania-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) orcania-deb; \
		xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%; \
	fi

orcania-ubuntu-latest-test: orcania-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) orcania-deb-test

orcania-ubuntu-lts-test: orcania-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) orcania-deb-test; \
	fi

orcania-alpine: orcania-source
	$(MAKE) alpine
	$(MAKE) orcania-tgz
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-alpine-test: orcania-alpine
	$(MAKE) alpine
	$(MAKE) orcania-tgz-test

orcania-fedora: orcania-source
	$(MAKE) fedora
	$(MAKE) orcania-rpm
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-fedora-test: orcania-fedora
	$(MAKE) fedora
	$(MAKE) orcania-rpm-test RPMI=yum

orcania-opensuse-tumbleweed: orcania-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) orcania-rpm
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-opensuse-tumbleweed-test: orcania-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) orcania-rpm-test RPMI=zypper

orcania-opensuse-leap: orcania-source
	$(MAKE) opensuse-leap
	$(MAKE) orcania-rpm
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-opensuse-leap-test: orcania-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) orcania-rpm-test RPMI=zypper

orcania-centos: orcania-source
	$(MAKE) centos
	$(MAKE) orcania-rpm
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-centos-test: orcania-centos
	$(MAKE) centos
	$(MAKE) orcania-rpm-test RPMI=yum

orcania-rocky: orcania-source
	$(MAKE) rocky
	$(MAKE) orcania-rpm
	xargs -a ./orcania/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=orcania TAG=$(ORCANIA_VERSION) PATTERN=./orcania/%

orcania-rocky-test: orcania-rocky
	$(MAKE) rocky
	$(MAKE) orcania-rpm-test RPMI=yum

orcania-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev pkg-config; \
	fi

orcania-local-deb: orcania-install-dependencies orcania-source
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
	$(MAKE) orcania-source-signed
	$(MAKE) orcania-debian-oldstable
	$(MAKE) orcania-debian-stable
	$(MAKE) orcania-debian-testing
	$(MAKE) orcania-ubuntu-latest
	$(MAKE) orcania-ubuntu-lts
	$(MAKE) orcania-alpine
	$(MAKE) orcania-fedora
	$(MAKE) orcania-centos
	$(MAKE) orcania-rocky
	#$(MAKE) orcania-opensuse-tumbleweed
	#$(MAKE) orcania-opensuse-leap

orcania-test:
	$(MAKE) orcania-debian-oldstable-test
	$(MAKE) orcania-debian-stable-test
	$(MAKE) orcania-debian-testing-test
	$(MAKE) orcania-ubuntu-latest-test
	$(MAKE) orcania-ubuntu-lts-test
	$(MAKE) orcania-alpine-test
	$(MAKE) orcania-fedora-test
	$(MAKE) orcania-centos-test
	$(MAKE) orcania-rocky-test
	#$(MAKE) orcania-opensuse-tumbleweed-test
	#$(MAKE) orcania-opensuse-leap-test
	@echo "#############################################"
	@echo "#          ORCANIA TESTS COMPLETE           #"
	@echo "#############################################"

orcania-clean: clean-base
	rm -f orcania/*.tar.gz orcania/*.zip orcania/*.deb orcania/*.rpm orcania/packages orcania/*.sig orcania/*.gpg
	-docker rmi -f babelouest/orcania
	-docker rmi -f babelouest/orcania-test

yder-source: yder/yder.tar.gz

yder-source-signed: yder/yder.tar.gz yder/yder.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes yder/yder.tar.gz || true; \
		gpg --detach-sign --yes yder/yder.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f yder/yder.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=yder tag=v$(YDER_VERSION) filename=yder/yder.tar.gz.sig; \
			fi; \
			if [ -f yder/yder.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=yder tag=v$(YDER_VERSION) filename=yder/yder.zip.sig; \
			fi; \
		fi \
	fi;

yder/yder.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O yder/yder.tar.gz https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz; \
	else \
		tar --exclude 'yder/.git/*' -cvzf yder/yder.tar.gz $(YDER_SRC); \
	fi

yder/yder.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O yder/yder.zip https://github.com/babelouest/yder/archive/v$(YDER_VERSION).zip; \
	fi

yder-deb:
	$(DOCKER_BUILD) -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/yder

yder-deb-test:
	cp yder/*.deb yder/test/deb/
	$(DOCKER_BUILD) -t babelouest/yder-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/test/deb/
	rm -f yder/test/deb/*.deb
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/yder-test

yder-tgz:
	$(DOCKER_BUILD) -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/yder

yder-tgz-test:
	cp yder/*.tar.gz yder/test/tgz/
	$(DOCKER_BUILD) -t babelouest/yder-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) yder/test/tgz/
	rm -f yder/test/tgz/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/yder-test

yder-rpm:
	$(DOCKER_BUILD) -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg RPMI=$(RPMI) yder/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/yder

yder-rpm-test:
	cp yder/*.rpm yder/test/rpm/
	$(DOCKER_BUILD) -t babelouest/yder-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg RPMI=$(RPMI) yder/test/rpm/
	rm -f yder/test/rpm/*.rpm
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/yder-test

yder-debian-oldstable: yder-source orcania-source
	$(MAKE) debian-oldstable
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-debian-stable: yder-source orcania-source
	$(MAKE) debian-stable
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-debian-oldstable-test: yder-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) yder-deb-test

yder-debian-stable-test: yder-debian-stable
	$(MAKE) debian-stable
	$(MAKE) yder-deb-test

yder-debian-testing: yder-source orcania-source
	$(MAKE) debian-testing
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-debian-testing-test: yder-debian-testing
	$(MAKE) debian-testing
	$(MAKE) yder-deb-test

yder-ubuntu-latest: yder-source orcania-source
	$(MAKE) ubuntu-latest
	$(MAKE) yder-deb
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-ubuntu-latest-test: yder-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) yder-deb-test

yder-ubuntu-lts: yder-source orcania-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) yder-deb; \
		xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%; \
	fi

yder-ubuntu-lts-test: yder-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) yder-deb-test; \
	fi

yder-alpine: yder-source orcania-source
	$(MAKE) alpine
	$(MAKE) yder-tgz
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-alpine-test: yder-alpine
	$(MAKE) alpine
	$(MAKE) yder-tgz-test

yder-fedora: yder-source orcania-source
	$(MAKE) fedora
	$(MAKE) yder-rpm RPMI=yum
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-fedora-test: yder-fedora
	$(MAKE) fedora
	$(MAKE) yder-rpm-test RPMI=yum

yder-opensuse-tumbleweed: yder-source orcania-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) yder-rpm RPMI=zypper
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-opensuse-tumbleweed-test: yder-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) yder-rpm-test RPMI=zypper

yder-opensuse-leap: yder-source orcania-source
	$(MAKE) opensuse-leap
	$(MAKE) yder-rpm RPMI=zypper
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-opensuse-leap-test: yder-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) yder-rpm-test RPMI=zypper

yder-centos: yder-source orcania-source
	$(MAKE) centos
	$(MAKE) yder-rpm RPMI=yum
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-centos-test: yder-centos
	$(MAKE) centos
	$(MAKE) yder-rpm-test RPMI=yum

yder-rocky: yder-source orcania-source
	$(MAKE) rocky
	$(MAKE) yder-rpm RPMI=yum
	xargs -a ./yder/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=yder TAG=$(YDER_VERSION) PATTERN=./yder/%

yder-rocky-test: yder-rocky
	$(MAKE) rocky
	$(MAKE) yder-rpm-test RPMI=yum

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
	$(MAKE) yder-source-signed
	$(MAKE) yder-debian-oldstable
	$(MAKE) yder-debian-stable
	$(MAKE) yder-debian-testing
	$(MAKE) yder-ubuntu-latest
	$(MAKE) yder-ubuntu-lts
	$(MAKE) yder-alpine
	$(MAKE) yder-fedora
	$(MAKE) yder-centos
	$(MAKE) yder-rocky
	#$(MAKE) yder-opensuse-tumbleweed
	#$(MAKE) yder-opensuse-leap

yder-test:
	$(MAKE) yder-debian-oldstable-test
	$(MAKE) yder-debian-stable-test
	$(MAKE) yder-debian-testing-test
	$(MAKE) yder-ubuntu-latest-test
	$(MAKE) yder-ubuntu-lts-test
	#$(MAKE) yder-alpine-test # Sometimes alpine is weird
	$(MAKE) yder-fedora-test
	$(MAKE) yder-centos-test
	$(MAKE) yder-rocky-test
	#$(MAKE) yder-opensuse-tumbleweed-test
	#$(MAKE) yder-opensuse-leap-test
	@echo "#############################################"
	@echo "#           YDER TESTS COMPLETE             #"
	@echo "#############################################"

yder-clean: clean-base
	rm -f yder/*.tar.gz yder/*.zip yder/*.deb yder/*.rpm yder/packages yder/*.sig yder/*.gpg
	-docker rmi -f babelouest/yder
	-docker rmi -f babelouest/yder-test

ulfius-source: ulfius/ulfius.tar.gz

ulfius-source-signed: ulfius/ulfius.tar.gz ulfius/ulfius.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes ulfius/ulfius.tar.gz || true; \
		gpg --detach-sign --yes ulfius/ulfius.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f ulfius/ulfius.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=ulfius tag=v$(ULFIUS_VERSION) filename=ulfius/ulfius.tar.gz.sig; \
			fi; \
			if [ -f ulfius/ulfius.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=ulfius tag=v$(ULFIUS_VERSION) filename=ulfius/ulfius.zip.sig; \
			fi; \
		fi \
	fi;

ulfius/ulfius.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O ulfius/ulfius.tar.gz https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz; \
	else \
		tar --exclude 'ulfius/.git/*' -cvzf ulfius/ulfius.tar.gz $(ULFIUS_SRC); \
	fi

ulfius/ulfius.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O ulfius/ulfius.zip https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).zip; \
	else \
		tar --exclude 'ulfius/.git/*' -cvzf ulfius/ulfius.zip $(ULFIUS_SRC); \
	fi

ulfius-deb:
	$(DOCKER_BUILD) -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/ulfius

ulfius-deb-test:
	cp ulfius/*.tar.gz ulfius/test/deb/
	$(DOCKER_BUILD) -t babelouest/ulfius-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/test/deb/
	rm -f ulfius/test/deb/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/ulfius-test

ulfius-tgz:
	$(DOCKER_BUILD) -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/ulfius

ulfius-tgz-test:
	cp ulfius/*.tar.gz ulfius/test/tgz/
	$(DOCKER_BUILD) -t babelouest/ulfius-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) ulfius/test/tgz/
	rm -f ulfius/test/tgz/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/ulfius-test

ulfius-rpm:
	$(DOCKER_BUILD) -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RPMI=$(RPMI) ulfius/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/ulfius

ulfius-rpm-test:
	cp ulfius/*.tar.gz ulfius/test/rpm/
	$(DOCKER_BUILD) -t babelouest/ulfius-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RPMI=$(RPMI) ulfius/test/rpm/
	rm -f ulfius/test/rpm/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/ulfius-test

ulfius-debian-oldstable: yder-source orcania-source ulfius-source
	$(MAKE) debian-oldstable
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-debian-stable: yder-source orcania-source ulfius-source
	$(MAKE) debian-stable
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-debian-oldstable-test: ulfius-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) ulfius-deb-test

ulfius-debian-stable-test: ulfius-debian-stable
	$(MAKE) debian-stable
	$(MAKE) ulfius-deb-test

ulfius-debian-testing: yder-source orcania-source ulfius-source
	$(MAKE) debian-testing
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-debian-testing-test: ulfius-debian-testing
	$(MAKE) debian-testing
	$(MAKE) ulfius-deb-test

ulfius-ubuntu-latest: yder-source orcania-source ulfius-source
	$(MAKE) ubuntu-latest
	$(MAKE) ulfius-deb
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-ubuntu-latest-test: ulfius-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) ulfius-deb-test

ulfius-ubuntu-lts: yder-source orcania-source ulfius-source
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) ulfius-deb; \
		xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%; \
	fi

ulfius-ubuntu-lts-test: ulfius-ubuntu-lts
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) ulfius-deb-test; \
	fi

ulfius-alpine: yder-source orcania-source ulfius-source
	$(MAKE) alpine
	$(MAKE) ulfius-tgz
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-alpine-test: ulfius-alpine
	$(MAKE) alpine
	$(MAKE) ulfius-tgz-test

ulfius-fedora: yder-source orcania-source ulfius-source
	$(MAKE) fedora
	$(MAKE) ulfius-rpm RPMI=yum
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-fedora-test: ulfius-fedora
	$(MAKE) fedora
	$(MAKE) ulfius-rpm-test RPMI=yum

ulfius-opensuse-tumbleweed: yder-source orcania-source ulfius-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) ulfius-rpm RPMI=zypper
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-opensuse-tumbleweed-test: ulfius-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) ulfius-rpm-test RPMI=zypper

ulfius-opensuse-leap: yder-source orcania-source ulfius-source
	$(MAKE) opensuse-leap
	$(MAKE) ulfius-rpm RPMI=zypper
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-opensuse-leap-test: ulfius-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) ulfius-rpm-test RPMI=zypper

ulfius-centos: yder-source orcania-source ulfius-source
	$(MAKE) centos
	$(MAKE) ulfius-rpm RPMI=yum
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-centos-test: ulfius-centos
	$(MAKE) centos
	$(MAKE) ulfius-rpm-test RPMI=yum

ulfius-rocky: yder-source orcania-source ulfius-source
	$(MAKE) rocky
	$(MAKE) ulfius-rpm RPMI=yum
	xargs -a ./ulfius/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=ulfius TAG=$(ULFIUS_VERSION) PATTERN=./ulfius/%

ulfius-rocky-test: ulfius-rocky
	$(MAKE) rocky
	$(MAKE) ulfius-rpm-test RPMI=yum

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
	$(MAKE) ulfius-source-signed
	$(MAKE) ulfius-debian-oldstable
	$(MAKE) ulfius-debian-stable
	$(MAKE) ulfius-debian-testing
	$(MAKE) ulfius-ubuntu-latest
	$(MAKE) ulfius-ubuntu-lts
	$(MAKE) ulfius-alpine
	$(MAKE) ulfius-fedora
	$(MAKE) ulfius-centos
	$(MAKE) ulfius-rocky
	#$(MAKE) ulfius-opensuse-tumbleweed
	#$(MAKE) ulfius-opensuse-leap

ulfius-test:
	$(MAKE) ulfius-debian-oldstable-test
	$(MAKE) ulfius-debian-stable-test
	$(MAKE) ulfius-debian-testing-test
	$(MAKE) ulfius-ubuntu-latest-test
	$(MAKE) ulfius-ubuntu-lts-test
	$(MAKE) ulfius-alpine-test
	$(MAKE) ulfius-fedora-test
	$(MAKE) ulfius-centos-test
	$(MAKE) ulfius-rocky-test
	#$(MAKE) ulfius-opensuse-tumbleweed-test
	#$(MAKE) ulfius-opensuse-leap-test
	@echo "#############################################"
	@echo "#          ULFIUS TESTS COMPLETE            #"
	@echo "#############################################"

ulfius-clean: clean-base
	rm -f ulfius/*.tar.gz ulfius/*.zip ulfius/*.deb ulfius/*.rpm ulfius/packages ulfius/*.sig ulfius/*.gpg
	-docker rmi -f babelouest/ulfius
	-docker rmi -f babelouest/ulfius-test

hoel-source: hoel/hoel.tar.gz

hoel-source-signed: hoel/hoel.tar.gz hoel/hoel.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes hoel/hoel.tar.gz || true; \
		gpg --detach-sign --yes hoel/hoel.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f hoel/hoel.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=hoel tag=v$(HOEL_VERSION) filename=hoel/hoel.tar.gz.sig; \
			fi; \
			if [ -f hoel/hoel.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=hoel tag=v$(HOEL_VERSION) filename=hoel/hoel.zip.sig; \
			fi; \
		fi \
	fi;

hoel/hoel.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O hoel/hoel.tar.gz https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz; \
	else \
		tar --exclude 'hoel/.git/*' -cvzf hoel/hoel.tar.gz $(HOEL_SRC); \
	fi

hoel/hoel.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O hoel/hoel.zip https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).zip; \
	fi

hoel-deb:
	$(DOCKER_BUILD) -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hoel

hoel-deb-test:
	cp hoel/*.tar.gz hoel/test/deb/
	$(DOCKER_BUILD) -t babelouest/hoel-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/test/deb/
	rm -f hoel/test/deb/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hoel-test

hoel-tgz:
	$(DOCKER_BUILD) -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hoel

hoel-tgz-test:
	cp hoel/*.tar.gz hoel/test/tgz/
	$(DOCKER_BUILD) -t babelouest/hoel-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) hoel/test/tgz/
	rm -f hoel/test/tgz/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hoel-test

hoel-rpm:
	$(DOCKER_BUILD) -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg RPMI=$(RPMI) hoel/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hoel

hoel-rpm-test:
	cp hoel/*.tar.gz hoel/test/rpm/
	$(DOCKER_BUILD) -t babelouest/hoel-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg RPMI=$(RPMI) hoel/test/rpm/
	rm -f hoel/test/rpm/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hoel-test

hoel-debian-oldstable: yder-source orcania-source hoel-source
	$(MAKE) debian-oldstable
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-debian-stable: yder-source orcania-source hoel-source
	$(MAKE) debian-stable
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-debian-oldstable-test: hoel-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) hoel-deb-test

hoel-debian-stable-test: hoel-debian-stable
	$(MAKE) debian-stable
	$(MAKE) hoel-deb-test

hoel-debian-testing: yder-source orcania-source hoel-source
	$(MAKE) debian-testing
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-debian-testing-test: hoel-debian-testing
	$(MAKE) debian-testing
	$(MAKE) hoel-deb-test

hoel-ubuntu-latest: yder-source orcania-source hoel-source
	$(MAKE) ubuntu-latest
	$(MAKE) hoel-deb
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-ubuntu-latest-test: hoel-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) hoel-deb-test

hoel-ubuntu-lts: yder-source orcania-source hoel-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hoel-deb; \
		xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%; \
	fi

hoel-ubuntu-lts-test: hoel-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hoel-deb-test; \
	fi

hoel-alpine: yder-source orcania-source hoel-source
	$(MAKE) alpine
	$(MAKE) hoel-tgz
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-alpine-test: hoel-alpine
	$(MAKE) alpine
	$(MAKE) hoel-tgz-test

hoel-fedora: yder-source orcania-source hoel-source
	$(MAKE) fedora
	$(MAKE) hoel-rpm RPMI=yum
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-fedora-test: hoel-fedora
	$(MAKE) fedora
	$(MAKE) hoel-rpm-test RPMI=yum

hoel-opensuse-tumbleweed: yder-source orcania-source hoel-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) hoel-rpm RPMI=zypper
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-opensuse-tumbleweed-test: hoel-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) hoel-rpm-test RPMI=zypper

hoel-opensuse-leap: yder-source orcania-source hoel-source
	$(MAKE) opensuse-leap
	$(MAKE) hoel-rpm RPMI=zypper
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-opensuse-leap-test: hoel-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) hoel-rpm-test RPMI=zypper

hoel-centos: yder-source orcania-source hoel-source
	$(MAKE) centos
	$(MAKE) hoel-rpm RPMI=yum
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-centos-test: hoel-centos
	$(MAKE) centos
	$(MAKE) hoel-rpm-test RPMI=yum

hoel-rocky: yder-source orcania-source hoel-source
	$(MAKE) rocky
	$(MAKE) hoel-rpm RPMI=yum
	xargs -a ./hoel/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hoel TAG=$(HOEL_VERSION) PATTERN=./hoel/%

hoel-rocky-test: hoel-rocky
	$(MAKE) rocky
	$(MAKE) hoel-rpm-test RPMI=yum

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
	$(MAKE) hoel-source-signed
	$(MAKE) hoel-debian-oldstable
	$(MAKE) hoel-debian-stable
	$(MAKE) hoel-debian-testing
	$(MAKE) hoel-ubuntu-latest
	$(MAKE) hoel-ubuntu-lts
	$(MAKE) hoel-alpine
	$(MAKE) hoel-fedora
	$(MAKE) hoel-centos
	$(MAKE) hoel-rocky
	#$(MAKE) hoel-opensuse-tumbleweed
	#$(MAKE) hoel-opensuse-leap

hoel-test:
	$(MAKE) hoel-debian-oldstable-test
	$(MAKE) hoel-debian-stable-test
	$(MAKE) hoel-debian-testing-test
	$(MAKE) hoel-ubuntu-latest-test
	$(MAKE) hoel-ubuntu-lts-test
	$(MAKE) hoel-alpine-test
	$(MAKE) hoel-fedora-test
	$(MAKE) hoel-centos-test
	$(MAKE) hoel-rocky-test
	#$(MAKE) hoel-opensuse-tumbleweed-test
	#$(MAKE) hoel-opensuse-leap-test
	@echo "#############################################"
	@echo "#            HOEL TESTS COMPLETE            #"
	@echo "#############################################"

hoel-clean: clean-base
	rm -f hoel/*.tar.gz hoel/*.zip hoel/*.deb hoel/*.rpm hoel/packages hoel/*.sig hoel/*.gpg
	-docker rmi -f babelouest/hoel
	-docker rmi -f babelouest/hoel-test

rhonabwy-source: rhonabwy/rhonabwy.tar.gz

rhonabwy-source-signed: rhonabwy/rhonabwy.tar.gz rhonabwy/rhonabwy.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes rhonabwy/rhonabwy.tar.gz || true; \
		gpg --detach-sign --yes rhonabwy/rhonabwy.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f rhonabwy/rhonabwy.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=rhonabwy tag=v$(RHONABWY_VERSION) filename=rhonabwy/rhonabwy.tar.gz.sig; \
			fi; \
			if [ -f rhonabwy/rhonabwy.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=rhonabwy tag=v$(RHONABWY_VERSION) filename=rhonabwy/rhonabwy.zip.sig; \
			fi; \
		fi \
	fi;

rhonabwy/rhonabwy.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O rhonabwy/rhonabwy.tar.gz https://github.com/babelouest/rhonabwy/archive/v$(RHONABWY_VERSION).tar.gz; \
	else \
		tar --exclude 'rhonabwy/.git/*' -cvzf rhonabwy/rhonabwy.tar.gz $(RHONABWY_SRC); \
	fi

rhonabwy/rhonabwy.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O rhonabwy/rhonabwy.zip https://github.com/babelouest/rhonabwy/archive/v$(RHONABWY_VERSION).zip; \
	fi

rhonabwy-deb:
	$(DOCKER_BUILD) -t babelouest/rhonabwy --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) rhonabwy/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/rhonabwy

rhonabwy-deb-test:
	cp rhonabwy/*.tar.gz rhonabwy/test/deb/
	$(DOCKER_BUILD) -t babelouest/rhonabwy-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) rhonabwy/test/deb/
	rm -f rhonabwy/test/deb/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/rhonabwy-test

rhonabwy-tgz:
	$(DOCKER_BUILD) -t babelouest/rhonabwy --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) rhonabwy/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/rhonabwy

rhonabwy-tgz-test:
	cp rhonabwy/*.tar.gz rhonabwy/test/tgz/
	$(DOCKER_BUILD) -t babelouest/rhonabwy-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) rhonabwy/test/tgz/
	rm -f rhonabwy/test/tgz/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/rhonabwy-test

rhonabwy-rpm:
	$(DOCKER_BUILD) -t babelouest/rhonabwy --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg RPMI=$(RPMI) rhonabwy/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/rhonabwy

rhonabwy-rpm-test:
	cp rhonabwy/*.tar.gz rhonabwy/test/rpm/
	$(DOCKER_BUILD) -t babelouest/rhonabwy-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg RPMI=$(RPMI) rhonabwy/test/rpm/
	rm -f rhonabwy/test/rpm/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/rhonabwy-test

rhonabwy-debian-oldstable: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) debian-oldstable
	$(MAKE) rhonabwy-deb
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-debian-stable: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) debian-stable
	$(MAKE) rhonabwy-deb
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-debian-oldstable-test: rhonabwy-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) rhonabwy-deb-test

rhonabwy-debian-stable-test: rhonabwy-debian-stable
	$(MAKE) debian-stable
	$(MAKE) rhonabwy-deb-test

rhonabwy-debian-testing: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) debian-testing
	$(MAKE) rhonabwy-deb
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-debian-testing-test: rhonabwy-debian-testing
	$(MAKE) debian-testing
	$(MAKE) rhonabwy-deb-test

rhonabwy-ubuntu-latest: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) ubuntu-latest
	$(MAKE) rhonabwy-deb
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-ubuntu-latest-test: rhonabwy-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) rhonabwy-deb-test

rhonabwy-ubuntu-lts: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) rhonabwy-deb; \
		xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%; \
	fi

rhonabwy-ubuntu-lts-test: rhonabwy-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) rhonabwy-deb-test; \
	fi

rhonabwy-alpine: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) alpine
	$(MAKE) rhonabwy-tgz
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-alpine-test: rhonabwy-alpine
	$(MAKE) alpine
	$(MAKE) rhonabwy-tgz-test

rhonabwy-fedora: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) fedora
	$(MAKE) rhonabwy-rpm RPMI=yum
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-fedora-test: rhonabwy-fedora
	$(MAKE) fedora
	$(MAKE) rhonabwy-rpm-test RPMI=yum

rhonabwy-opensuse-tumbleweed: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) rhonabwy-rpm RPMI=zypper
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-opensuse-tumbleweed-test: rhonabwy-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) rhonabwy-rpm-test RPMI=zypper

rhonabwy-opensuse-leap: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) opensuse-leap
	$(MAKE) rhonabwy-rpm RPMI=zypper
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-opensuse-leap-test: rhonabwy-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) rhonabwy-rpm-test RPMI=zypper

rhonabwy-centos: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) centos
	$(MAKE) rhonabwy-rpm RPMI=yum
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-centos-test: rhonabwy-centos
	$(MAKE) centos
	$(MAKE) rhonabwy-rpm-test RPMI=yum

rhonabwy-rocky: yder-source orcania-source ulfius-source rhonabwy-source
	$(MAKE) rocky
	$(MAKE) rhonabwy-rpm RPMI=yum
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-rocky-test: rhonabwy-rocky
	$(MAKE) rocky
	$(MAKE) rhonabwy-rpm-test RPMI=yum

rhonabwy-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libpq-dev pkg-config; \
	fi

rhonabwy-local-deb: rhonabwy-install-dependencies
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
	cp liborcania-dev_*.deb ../../../rhonabwy/liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

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
	cp libyder-dev_*.deb ../../../rhonabwy/libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package rhonabwy
	wget https://github.com/babelouest/rhonabwy/archive/v$(RHONABWY_VERSION).tar.gz -O build/v$(RHONABWY_VERSION).tar.gz
	tar xf build/v$(RHONABWY_VERSION).tar.gz -C build/
	rm -f build/v$(RHONABWY_VERSION).tar.gz
	( cd build/rhonabwy-$(RHONABWY_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make package; \
	cp librhonabwy-dev_*.deb ../../../rhonabwy/librhonabwy-dev_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd rhonabwy && tar cvz liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb librhonabwy-dev_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f rhonabwy-dev-full_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo librhonabwy-dev_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./rhonabwy/packages
	echo rhonabwy-dev-full_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./rhonabwy/packages
	xargs -a ./rhonabwy/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=rhonabwy TAG=$(RHONABWY_VERSION) PATTERN=./rhonabwy/%

rhonabwy-build:
	$(MAKE) rhonabwy-source-signed
	$(MAKE) rhonabwy-debian-oldstable
	$(MAKE) rhonabwy-debian-stable
	$(MAKE) rhonabwy-debian-testing
	$(MAKE) rhonabwy-ubuntu-latest
	$(MAKE) rhonabwy-ubuntu-lts
	$(MAKE) rhonabwy-alpine
	$(MAKE) rhonabwy-fedora
	$(MAKE) rhonabwy-centos
	$(MAKE) rhonabwy-rocky
	#$(MAKE) rhonabwy-opensuse-tumbleweed
	#$(MAKE) rhonabwy-opensuse-leap

rhonabwy-test:
	$(MAKE) rhonabwy-debian-oldstable-test
	$(MAKE) rhonabwy-debian-stable-test
	$(MAKE) rhonabwy-debian-testing-test
	$(MAKE) rhonabwy-ubuntu-latest-test
	$(MAKE) rhonabwy-ubuntu-lts-test
	$(MAKE) rhonabwy-alpine-test
	$(MAKE) rhonabwy-fedora-test
	$(MAKE) rhonabwy-centos-test
	$(MAKE) rhonabwy-rocky-test
	#$(MAKE) rhonabwy-opensuse-tumbleweed-test
	#$(MAKE) rhonabwy-opensuse-leap-test
	@echo "#############################################"
	@echo "#            RHONABWY TESTS COMPLETE        #"
	@echo "#############################################"

rhonabwy-clean: clean-base
	rm -f rhonabwy/*.tar.gz rhonabwy/*.zip rhonabwy/*.deb rhonabwy/*.rpm rhonabwy/packages rhonabwy/*.sig rhonabwy/*.gpg
	-docker rmi -f babelouest/rhonabwy
	-docker rmi -f babelouest/rhonabwy-test

iddawc-source: iddawc/iddawc.tar.gz

iddawc-source-signed: iddawc/iddawc.tar.gz iddawc/iddawc.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes iddawc/iddawc.tar.gz || true; \
		gpg --detach-sign --yes iddawc/iddawc.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f iddawc/iddawc.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=iddawc tag=v$(IDDAWC_VERSION) filename=iddawc/iddawc.tar.gz.sig; \
			fi; \
			if [ -f iddawc/iddawc.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=iddawc tag=v$(IDDAWC_VERSION) filename=iddawc/iddawc.zip.sig; \
			fi; \
		fi \
	fi;

iddawc/iddawc.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O iddawc/iddawc.tar.gz https://github.com/babelouest/iddawc/archive/v$(IDDAWC_VERSION).tar.gz; \
	else \
		tar --exclude 'iddawc/.git/*' -cvzf iddawc/iddawc.tar.gz $(IDDAWC_SRC); \
	fi

iddawc/iddawc.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O iddawc/iddawc.zip https://github.com/babelouest/iddawc/archive/v$(IDDAWC_VERSION).zip; \
	fi

iddawc-deb:
	$(DOCKER_BUILD) -t babelouest/iddawc --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) iddawc/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/iddawc

iddawc-deb-test:
	cp iddawc/*.tar.gz iddawc/test/deb/
	$(DOCKER_BUILD) -t babelouest/iddawc-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) iddawc/test/deb/
	rm -f iddawc/test/deb/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/iddawc-test

iddawc-tgz:
	$(DOCKER_BUILD) -t babelouest/iddawc --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) iddawc/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/iddawc

iddawc-tgz-test:
	cp iddawc/*.tar.gz iddawc/test/tgz/
	$(DOCKER_BUILD) -t babelouest/iddawc-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) iddawc/test/tgz/
	rm -f iddawc/test/tgz/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/iddawc-test

iddawc-rpm:
	$(DOCKER_BUILD) -t babelouest/iddawc --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) --build-arg RPMI=$(RPMI) iddawc/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/iddawc

iddawc-rpm-test:
	cp iddawc/*.tar.gz iddawc/test/rpm/
	$(DOCKER_BUILD) -t babelouest/iddawc-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) --build-arg RPMI=$(RPMI) iddawc/test/rpm/
	rm -f iddawc/test/rpm/*.tar.gz
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/iddawc-test

iddawc-debian-oldstable: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) debian-oldstable
	$(MAKE) iddawc-deb
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-debian-stable: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) debian-stable
	$(MAKE) iddawc-deb
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-debian-oldstable-test: iddawc-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) iddawc-deb-test

iddawc-debian-stable-test: iddawc-debian-stable
	$(MAKE) debian-stable
	$(MAKE) iddawc-deb-test

iddawc-debian-testing: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) debian-testing
	$(MAKE) iddawc-deb
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-debian-testing-test: iddawc-debian-testing
	$(MAKE) debian-testing
	$(MAKE) iddawc-deb-test

iddawc-ubuntu-latest: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) ubuntu-latest
	$(MAKE) iddawc-deb
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-ubuntu-latest-test: iddawc-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) iddawc-deb-test

iddawc-ubuntu-lts: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) iddawc-deb; \
		xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%; \
	fi

iddawc-ubuntu-lts-test: iddawc-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) iddawc-deb-test; \
	fi

iddawc-alpine: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) alpine
	$(MAKE) iddawc-tgz
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-alpine-test: iddawc-alpine
	$(MAKE) alpine
	$(MAKE) iddawc-tgz-test

iddawc-fedora: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) fedora
	$(MAKE) iddawc-rpm RPMI=yum
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-fedora-test: iddawc-fedora
	$(MAKE) fedora
	$(MAKE) iddawc-rpm-test RPMI=yum

iddawc-opensuse-tumbleweed: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) iddawc-rpm RPMI=zypper
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-opensuse-tumbleweed-test: iddawc-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) iddawc-rpm-test RPMI=zypper

iddawc-opensuse-leap: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) opensuse-leap
	$(MAKE) iddawc-rpm RPMI=zypper
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-opensuse-leap-test: iddawc-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) iddawc-rpm-test RPMI=zypper

iddawc-centos: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) centos
	$(MAKE) iddawc-rpm RPMI=yum
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-centos-test: iddawc-centos
	$(MAKE) centos
	$(MAKE) iddawc-rpm-test RPMI=yum

iddawc-rocky: yder-source orcania-source ulfius-source rhonabwy-source iddawc-source
	$(MAKE) rocky
	$(MAKE) iddawc-rpm RPMI=yum
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-rocky-test: iddawc-rocky
	$(MAKE) rocky
	$(MAKE) iddawc-rpm-test RPMI=yum

iddawc-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libpq-dev pkg-config; \
	fi

iddawc-local-deb: iddawc-install-dependencies
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
	cp liborcania-dev_*.deb ../../../iddawc/liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

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
	cp libyder-dev_*.deb ../../../iddawc/libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

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
	cp libulfius_*.deb ../../../iddawc/libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	
	# package rhonabwy
	wget https://github.com/babelouest/rhonabwy/archive/v$(RHONABWY_VERSION).tar.gz -O build/v$(RHONABWY_VERSION).tar.gz
	tar xf build/v$(RHONABWY_VERSION).tar.gz -C build/
	rm -f build/v$(RHONABWY_VERSION).tar.gz
	( cd build/rhonabwy-$(RHONABWY_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp librhonabwy_*.deb ../../../iddawc/librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package iddawc
	wget https://github.com/babelouest/iddawc/archive/v$(IDDAWC_VERSION).tar.gz -O build/v$(IDDAWC_VERSION).tar.gz
	tar xf build/v$(IDDAWC_VERSION).tar.gz -C build/
	rm -f build/v$(IDDAWC_VERSION).tar.gz
	( cd build/iddawc-$(IDDAWC_VERSION) && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make package; \
	cp libiddawc-dev_*.deb ../../../iddawc/libiddawc-dev_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd iddawc && tar cvz liborcania-dev_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder-dev_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libiddawc-dev_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f iddawc-dev-full_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo libiddawc-dev_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./iddawc/packages
	echo iddawc-dev-full_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./iddawc/packages
	xargs -a ./iddawc/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=iddawc TAG=$(IDDAWC_VERSION) PATTERN=./iddawc/%

iddawc-build:
	$(MAKE) iddawc-source-signed
	$(MAKE) iddawc-debian-oldstable
	$(MAKE) iddawc-debian-stable
	$(MAKE) iddawc-debian-testing
	$(MAKE) iddawc-ubuntu-latest
	$(MAKE) iddawc-ubuntu-lts
	$(MAKE) iddawc-alpine
	$(MAKE) iddawc-fedora
	$(MAKE) iddawc-centos
	$(MAKE) iddawc-rocky
	#$(MAKE) iddawc-opensuse-tumbleweed
	#$(MAKE) iddawc-opensuse-leap

iddawc-test:
	$(MAKE) iddawc-debian-oldstable-test
	$(MAKE) iddawc-debian-stable-test
	$(MAKE) iddawc-debian-testing-test
	$(MAKE) iddawc-ubuntu-latest-test
	$(MAKE) iddawc-ubuntu-lts-test
	$(MAKE) iddawc-alpine-test
	$(MAKE) iddawc-fedora-test
	$(MAKE) iddawc-centos-test
	$(MAKE) iddawc-rocky-test
	#$(MAKE) iddawc-opensuse-tumbleweed-test
	#$(MAKE) iddawc-opensuse-leap-test
	@echo "#############################################"
	@echo "#            IDDAWC TESTS COMPLETE        #"
	@echo "#############################################"

iddawc-clean: clean-base
	rm -f iddawc/*.tar.gz iddawc/*.zip iddawc/*.deb iddawc/*.rpm iddawc/packages iddawc/*.sig iddawc/*.gpg
	-docker rmi -f babelouest/iddawc
	-docker rmi -f babelouest/iddawc-test

glewlwyd-source: glewlwyd/glewlwyd.tar.gz

glewlwyd-source-signed: glewlwyd/glewlwyd.tar.gz glewlwyd/glewlwyd.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes glewlwyd/glewlwyd.tar.gz || true; \
		gpg --detach-sign --yes glewlwyd/glewlwyd.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f glewlwyd/glewlwyd.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=glewlwyd tag=v$(GLEWLWYD_VERSION) filename=glewlwyd/glewlwyd.tar.gz.sig; \
			fi; \
			if [ -f glewlwyd/glewlwyd.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=glewlwyd tag=v$(GLEWLWYD_VERSION) filename=glewlwyd/glewlwyd.zip.sig; \
			fi; \
		fi \
	fi;

glewlwyd/glewlwyd.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O glewlwyd/glewlwyd.tar.gz https://github.com/babelouest/glewlwyd/archive/v$(GLEWLWYD_VERSION).tar.gz; \
	else \
		tar --exclude='glewlwyd/webapp-src/node_modules*' --exclude 'glewlwyd/.git/*' -cvzf glewlwyd/glewlwyd.tar.gz $(GLEWLWYD_SRC); \
	fi

glewlwyd/glewlwyd.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O glewlwyd/glewlwyd.zip https://github.com/babelouest/glewlwyd/archive/v$(GLEWLWYD_VERSION).zip; \
	fi

glewlwyd-deb:
	$(DOCKER_BUILD) -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/glewlwyd

glewlwyd-deb-test:
	$(DOCKER_BUILD) -t babelouest/glewlwyd-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/test/deb/
	$(DOCKER_RUN) --rm -p 4593:4593 -v $(shell pwd)/:/share babelouest/glewlwyd-test

glewlwyd-deb-memcheck:
	$(DOCKER_BUILD) -t babelouest/glewlwyd-memcheck --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/memcheck/deb/
	$(DOCKER_RUN) --rm -p 4593:4593 -v $(shell pwd)/:/share babelouest/glewlwyd-memcheck

glewlwyd-deb-smoke:
	cp glewlwyd/glewlwyd-full_*.tar.gz glewlwyd/smoke/deb/
	$(DOCKER_BUILD) -t babelouest/glewlwyd-smoke --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/smoke/deb/
	rm -f glewlwyd/smoke/deb/glewlwyd-full_*.tar.gz
	$(DOCKER_RUN) --rm -it -p 4593:4593 babelouest/glewlwyd-smoke

glewlwyd-tgz:
	$(DOCKER_BUILD) -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/glewlwyd

glewlwyd-tgz-test:
	$(DOCKER_BUILD) -t babelouest/glewlwyd-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/test/tgz/
	$(DOCKER_RUN) --rm -p 4593:4593 -v $(shell pwd)/:/share babelouest/glewlwyd-test

glewlwyd-tgz-memcheck:
	$(DOCKER_BUILD) -t babelouest/glewlwyd-memcheck --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/memcheck/tgz/
	$(DOCKER_RUN) --rm -p 4593:4593 -v $(shell pwd)/:/share babelouest/glewlwyd-memcheck

glewlwyd-tgz-smoke:
	cp glewlwyd/glewlwyd-full_*.tar.gz glewlwyd/smoke/tgz/
	$(DOCKER_BUILD) -t babelouest/glewlwyd-smoke --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) glewlwyd/smoke/tgz/
	rm -f glewlwyd/smoke/tgz/glewlwyd-full_*.tar.gz
	$(DOCKER_RUN) --rm -it -p 4593:4593 babelouest/glewlwyd-smoke

glewlwyd-rpm:
	$(DOCKER_BUILD) -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) --build-arg RPMI=$(RPMI) glewlwyd/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/glewlwyd

glewlwyd-rpm-test:
	$(DOCKER_BUILD) -t babelouest/glewlwyd-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) --build-arg RPMI=$(RPMI) glewlwyd/test/rpm/
	$(DOCKER_RUN) --rm -it -p 4593:4593 -v $(shell pwd)/:/share babelouest/glewlwyd-test

glewlwyd-rpm-memcheck:
	$(DOCKER_BUILD) -t babelouest/glewlwyd-memcheck --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg LIBJANSSON_VERSION=$(LIBJANSSON_VERSION) --build-arg RPMI=$(RPMI) glewlwyd/memcheck/rpm/
	$(DOCKER_RUN) --rm -it -p 4593:4593 -v $(shell pwd)/:/share babelouest/glewlwyd-memcheck

glewlwyd-rpm-smoke:
	cp glewlwyd/glewlwyd-full_*.tar.gz glewlwyd/smoke/rpm/
	$(DOCKER_BUILD) -t babelouest/glewlwyd-smoke --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBCBOR_VERSION=$(LIBCBOR_VERSION) --build-arg RPMI=$(RPMI) glewlwyd/smoke/rpm/
	rm -f glewlwyd/smoke/rpm/glewlwyd-full_*.tar.gz
	$(DOCKER_RUN) --rm -it -p 4593:4593 babelouest/glewlwyd-smoke

glewlwyd-debian-oldstable: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) debian-oldstable
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-debian-oldstable-test: glewlwyd-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) glewlwyd-deb-test

glewlwyd-debian-oldstable-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) debian-oldstable
	$(MAKE) glewlwyd-deb-memcheck

glewlwyd-debian-oldstable-smoke: glewlwyd-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) glewlwyd-deb-smoke

glewlwyd-debian-stable: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-debian-stable-test: glewlwyd-debian-stable
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb-test

glewlwyd-debian-stable-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb-memcheck

glewlwyd-debian-stable-smoke: glewlwyd-debian-stable
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb-smoke

glewlwyd-debian-testing: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-debian-testing-test: glewlwyd-debian-testing
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb-test

glewlwyd-debian-testing-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb-memcheck

glewlwyd-debian-testing-smoke: glewlwyd-debian-testing
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb-smoke

glewlwyd-ubuntu-latest: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-ubuntu-latest-test: glewlwyd-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb-test

glewlwyd-ubuntu-latest-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb-memcheck

glewlwyd-ubuntu-latest-smoke: glewlwyd-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb-smoke

glewlwyd-ubuntu-lts: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) glewlwyd-deb; \
		xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%; \
	fi

glewlwyd-ubuntu-lts-test: glewlwyd-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) glewlwyd-deb-test; \
	fi

glewlwyd-ubuntu-lts-memcheck:
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) glewlwyd-deb-memcheck; \
	fi

glewlwyd-ubuntu-lts-smoke: glewlwyd-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) glewlwyd-deb-smoke; \
	fi

glewlwyd-alpine: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-alpine-test: glewlwyd-alpine
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz-test

glewlwyd-alpine-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz-memcheck

glewlwyd-alpine-smoke: glewlwyd-alpine
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz-smoke

glewlwyd-fedora: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) fedora
	$(MAKE) glewlwyd-rpm RPMI=yum
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-fedora-test: glewlwyd-fedora
	$(MAKE) fedora
	$(MAKE) glewlwyd-rpm-test RPMI=yum

glewlwyd-fedora-memcheck:
	$(MAKE) fedora
	$(MAKE) glewlwyd-rpm-memcheck RPMI=yum

glewlwyd-fedora-smoke: glewlwyd-fedora
	$(MAKE) fedora
	$(MAKE) glewlwyd-rpm-smoke RPMI=yum

glewlwyd-opensuse-tumbleweed: yder-source orcania-source hoel-source rhonabwy-source iddawc-source ulfius-source glewlwyd-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) glewlwyd-rpm RPMI=zypper
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-opensuse-tumbleweed-test: glewlwyd-opensuse-tumbleweed
	$(MAKE) opensuse-tumbleweed
	$(MAKE) glewlwyd-rpm-test RPMI=zypper

glewlwyd-opensuse-tumbleweed-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) opensuse-tumbleweed
	$(MAKE) glewlwyd-rpm-memcheck RPMI=zypper

#glewlwyd-opensuse-tumbleweed-smoke: glewlwyd-opensuse-tumbleweed
#	$(MAKE) opensuse-tumbleweed
#	$(MAKE) glewlwyd-rpm-smoke RPMI=zypper

glewlwyd-opensuse-leap: yder-source orcania-source hoel-source rhonabwy-source iddawc-source ulfius-source glewlwyd-source
	$(MAKE) opensuse-leap
	$(MAKE) glewlwyd-rpm RPMI=zypper
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-opensuse-leap-test: glewlwyd-opensuse-leap
	$(MAKE) opensuse-leap
	$(MAKE) glewlwyd-rpm-test RPMI=zypper

glewlwyd-opensuse-leap-memcheck: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) opensuse-leap
	$(MAKE) glewlwyd-rpm-memcheck RPMI=zypper

#glewlwyd-opensuse-leap-smoke: glewlwyd-opensuse-leap
#	$(MAKE) opensuse-leap
#	$(MAKE) glewlwyd-rpm-smoke RPMI=zypper

glewlwyd-centos: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) centos
	$(MAKE) glewlwyd-rpm RPMI=yum
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-centos-test: glewlwyd-centos
	$(MAKE) centos
	$(MAKE) glewlwyd-rpm-test RPMI=yum

glewlwyd-centos-memcheck:
	$(MAKE) centos
	$(MAKE) glewlwyd-rpm-memcheck RPMI=yum

glewlwyd-centos-smoke: glewlwyd-centos
	$(MAKE) centos
	$(MAKE) glewlwyd-rpm-smoke RPMI=yum

glewlwyd-rocky: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source glewlwyd-source
	$(MAKE) rocky
	$(MAKE) glewlwyd-rpm RPMI=yum
	xargs -a ./glewlwyd/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=glewlwyd TAG=$(GLEWLWYD_VERSION) PATTERN=./glewlwyd/%

glewlwyd-rocky-test: glewlwyd-rocky
	$(MAKE) rocky
	$(MAKE) glewlwyd-rpm-test RPMI=yum

glewlwyd-rocky-memcheck:
	$(MAKE) rocky
	$(MAKE) glewlwyd-rpm-memcheck RPMI=yum

glewlwyd-rocky-smoke: glewlwyd-rocky
	$(MAKE) rocky
	$(MAKE) glewlwyd-rpm-smoke RPMI=yum

glewlwyd-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libmicrohttpd-dev libjansson-dev libsystemd-dev uuid-dev libldap2-dev default-libmysqlclient-dev libpq-dev libsqlite3-dev libconfig-dev libgnutls28-dev libcurl4-gnutls-dev libssl-dev pkg-config libpq-dev liboath-dev libcbor-dev liboath-dev; \
	fi

glewlwyd-local-deb: glewlwyd-install-dependencies glewlwyd-source rhonabwy-source iddawc-source ulfius-source hoel-source yder-source orcania-source
	mkdir -p build/orcania build/yder build/ulfius build/hoel build/rhonabwy build/iddawc build/glewlwyd
	# package orcania
	#wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf orcania/orcania.tar.gz -C build/orcania/ --strip 1
	( cd build/orcania && \
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
	#wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf yder/yder.tar.gz -C build/yder/ --strip 1
	( cd build/yder && \
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
	#wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf ulfius/ulfius.tar.gz -C build/ulfius/ --strip 1
	( cd build/ulfius && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make && \
	make package; \
	cp libulfius_*.deb ../../../glewlwyd/libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )
	
	# package hoel
	#wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf hoel/hoel.tar.gz -C build/hoel/ --strip 1
	( cd build/hoel && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../glewlwyd/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package rhonabwy
	#wget https://github.com/babelouest/rhonabwy/archive/v$(RHONABWY_VERSION).tar.gz -O build/v$(RHONABWY_VERSION).tar.gz
	tar xf rhonabwy/rhonabwy.tar.gz -C build/rhonabwy/ --strip 1
	( cd build/rhonabwy && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp librhonabwy_*.deb ../../../glewlwyd/librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package iddawc
	#wget https://github.com/babelouest/iddawc/archive/v$(IDDAWC_VERSION).tar.gz -O build/v$(IDDAWC_VERSION).tar.gz
	tar xf iddawc/iddawc.tar.gz -C build/iddawc/ --strip 1
	( cd build/iddawc && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp libiddawc_*.deb ../../../glewlwyd/libiddawc_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package glewlwyd
	#wget https://github.com/babelouest/glewlwyd/archive/v$(GLEWLWYD_VERSION).tar.gz -O build/v$(GLEWLWYD_VERSION).tar.gz
	tar xf glewlwyd/glewlwyd.tar.gz -C build/glewlwyd/ --strip 1
	( cd build/glewlwyd && \
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
	$(MAKE) glewlwyd-source-signed
	$(MAKE) glewlwyd-debian-oldstable
	$(MAKE) glewlwyd-debian-stable
	$(MAKE) glewlwyd-debian-testing
	$(MAKE) glewlwyd-ubuntu-latest
	$(MAKE) glewlwyd-ubuntu-lts
	$(MAKE) glewlwyd-alpine
	$(MAKE) glewlwyd-fedora
	#$(MAKE) glewlwyd-rocky
	#$(MAKE) glewlwyd-centos
	#-$(MAKE) glewlwyd-opensuse-tumbleweed
	#-$(MAKE) glewlwyd-opensuse-leap

glewlwyd-test:
	$(MAKE) glewlwyd-debian-oldstable-test
	$(MAKE) glewlwyd-debian-stable-test
	$(MAKE) glewlwyd-debian-testing-test
	$(MAKE) glewlwyd-ubuntu-latest-test
	$(MAKE) glewlwyd-ubuntu-lts-test
	$(MAKE) glewlwyd-alpine-test
	$(MAKE) glewlwyd-fedora-test
	#$(MAKE) glewlwyd-rocky-test
	#$(MAKE) glewlwyd-centos-test
	#$(MAKE) glewlwyd-opensuse-tumbleweed-test
	#$(MAKE) glewlwyd-opensuse-leap-test
	@echo "#############################################"
	@echo "#          GLEWLWYD TESTS COMPLETE          #"
	@echo "#############################################"

glewlwyd-memcheck:
	$(MAKE) glewlwyd-debian-oldstable-memcheck
	$(MAKE) glewlwyd-debian-stable-memcheck
	$(MAKE) glewlwyd-debian-testing-memcheck
	$(MAKE) glewlwyd-ubuntu-latest-memcheck
	$(MAKE) glewlwyd-ubuntu-lts-memcheck
	$(MAKE) glewlwyd-alpine-memcheck
	$(MAKE) glewlwyd-fedora-memcheck
	#-$(MAKE) glewlwyd-opensuse-tumbleweed-memcheck
	#-$(MAKE) glewlwyd-opensuse-leap-memcheck
	@echo "#############################################"
	@echo "#         GLEWLWYD MEMCHECK COMPLETE        #"
	@echo "#############################################"

glewlwyd-clean: clean-base
	rm -f glewlwyd/*.tar.gz glewlwyd/*.zip glewlwyd/*.deb glewlwyd/*.rpm glewlwyd/packages glewlwyd/valgrind* glewlwyd/*.sig glewlwyd/*.gpg
	-docker rmi -f babelouest/glewlwyd
	-docker rmi -f babelouest/glewlwyd-test
	-docker rmi -f babelouest/glewlwyd-smoke
	-docker rmi -f babelouest/glewlwyd-memcheck

taliesin-source: taliesin/taliesin.tar.gz

taliesin-source-signed: taliesin/taliesin.tar.gz taliesin/taliesin.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes taliesin/taliesin.tar.gz || true; \
		gpg --detach-sign --yes taliesin/taliesin.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f taliesin/taliesin.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=taliesin tag=v$(TALIESIN_VERSION) filename=taliesin/taliesin.tar.gz.sig; \
			fi; \
			if [ -f taliesin/taliesin.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=taliesin tag=v$(TALIESIN_VERSION) filename=taliesin/taliesin.zip.sig; \
			fi; \
		fi \
	fi;

taliesin/taliesin.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O taliesin/taliesin.tar.gz https://github.com/babelouest/taliesin/archive/v$(TALIESIN_VERSION).tar.gz; \
	else \
		tar --exclude='taliesin/webapp-src/node_modules*' --exclude 'taliesin/.git/*' --exclude 'taliesin/test/media/*' -cvzf taliesin/taliesin.tar.gz $(TALIESIN_SRC); \
	fi

taliesin/taliesin.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O taliesin/taliesin.zip https://github.com/babelouest/taliesin/archive/v$(TALIESIN_VERSION).zip; \
	fi

taliesin-deb:
	$(DOCKER_BUILD) -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) taliesin/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/taliesin

taliesin-tgz:
	$(DOCKER_BUILD) -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) taliesin/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/taliesin

taliesin-debian-stable: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source taliesin-source
	$(MAKE) debian-stable
	$(MAKE) taliesin-deb
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-debian-testing: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source taliesin-source
	$(MAKE) debian-testing
	$(MAKE) taliesin-deb
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-ubuntu-latest: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source taliesin-source
	$(MAKE) ubuntu-latest
	$(MAKE) taliesin-deb
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-ubuntu-lts: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source taliesin-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) taliesin-deb; \
		xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%; \
	fi

taliesin-alpine: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source taliesin-source
	$(MAKE) alpine
	$(MAKE) taliesin-tgz
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libconfig-dev libjansson-dev libsystemd-dev libgnutls28-dev libssl-dev libmicrohttpd-dev libmariadbclient-dev libsqlite3-dev libtool libavfilter-dev libavcodec-dev libavformat-dev libswresample-dev libavutil-dev pkg-config zlib1g-dev; \
	fi

taliesin-local-deb: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source taliesin-source taliesin-install-dependencies
	mkdir -p build/orcania build/yder build/ulfius build/hoel build/rhonabwy build/iddawc build/taliesin
	# package orcania
	tar xf orcania/orcania.tar.gz -C build/orcania/ --strip 1
	( cd build/orcania && \
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
	tar xf yder/yder.tar.gz -C build/yder/ --strip 1
	( cd build/yder && \
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
	tar xf ulfius/ulfius.tar.gz -C build/ulfius/ --strip 1
	( cd build/ulfius && \
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
	tar xf hoel/hoel.tar.gz -C build/hoel/ --strip 1
	( cd build/hoel && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../taliesin/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package rhonabwy
	tar xf rhonabwy/rhonabwy.tar.gz -C build/rhonabwy/ --strip 1
	( cd build/rhonabwy && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp librhonabwy_*.deb ../../../taliesin/librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package iddawc
	tar xf iddawc/iddawc.tar.gz -C build/iddawc/ --strip 1
	( cd build/iddawc && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp libiddawc_*.deb ../../../taliesin/libiddawc_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package taliesin
	tar xf taliesin/taliesin.tar.gz -C build/taliesin/ --strip 1
	( cd build/taliesin && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp taliesin_*.deb ../../../taliesin/taliesin_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd taliesin && tar cvz liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libiddawc_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb taliesin_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f taliesin-full_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo taliesin_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./taliesin/packages
	echo taliesin-full_$(TALIESIN_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./taliesin/packages
	xargs -a ./taliesin/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=taliesin TAG=$(TALIESIN_VERSION) PATTERN=./taliesin/%

taliesin-build:
	$(MAKE) taliesin-source-signed
	$(MAKE) taliesin-debian-stable
	$(MAKE) taliesin-debian-testing
	$(MAKE) taliesin-ubuntu-latest
	$(MAKE) taliesin-ubuntu-lts
	$(MAKE) taliesin-alpine

taliesin-clean: clean-base
	rm -f taliesin/*.tar.gz taliesin/*.zip taliesin/*.deb taliesin/packages taliesin/*.sig taliesin/*.gpg
	-docker rmi -f babelouest/taliesin

hutch-source: hutch/hutch.tar.gz

hutch-source-signed: hutch/hutch.tar.gz hutch/hutch.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes hutch/hutch.tar.gz || true; \
		gpg --detach-sign --yes hutch/hutch.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f hutch/hutch.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=hutch tag=v$(HUTCH_VERSION) filename=hutch/hutch.tar.gz.sig; \
			fi; \
			if [ -f hutch/hutch.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=hutch tag=v$(HUTCH_VERSION) filename=hutch/hutch.zip.sig; \
			fi; \
		fi \
	fi;

hutch/hutch.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O hutch/hutch.zip https://github.com/babelouest/hutch/archive/v$(HUTCH_VERSION).zip; \
	fi

hutch/hutch.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O hutch/hutch.tar.gz https://github.com/babelouest/hutch/archive/v$(HUTCH_VERSION).tar.gz; \
	else \
		tar --exclude='hutch/webapp-src/node_modules*' --exclude 'hutch/.git/*' -cvzf hutch/hutch.tar.gz $(HUTCH_SRC); \
	fi

hutch-deb:
	$(DOCKER_BUILD) -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) hutch/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hutch

hutch-tgz:
	$(DOCKER_BUILD) -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) hutch/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hutch

hutch-rpm:
	$(DOCKER_BUILD) -t babelouest/hutch --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg RPMI=$(RPMI) hutch/build/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hutch

hutch-deb-test:
	$(DOCKER_BUILD) -t babelouest/hutch-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) hutch/test/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hutch-test

hutch-tgz-test:
	$(DOCKER_BUILD) -t babelouest/hutch-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) hutch/test/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hutch-test

hutch-rpm-test:
	$(DOCKER_BUILD) -t babelouest/hutch-test --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) hutch/test/rpm/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/hutch-test

hutch-deb-smoke:
	cp hutch/hutch-full_*.tar.gz hutch/smoke/deb/
	$(DOCKER_BUILD) -t babelouest/hutch-smoke --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) hutch/smoke/deb/
	rm -f hutch/smoke/deb/hutch-full_*.tar.gz
	$(DOCKER_RUN) --rm -it -p 4884:4884 babelouest/hutch-smoke

hutch-tgz-smoke:
	cp hutch/hutch-full_*.tar.gz hutch/smoke/tgz/
	$(DOCKER_BUILD) -t babelouest/hutch-smoke --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) hutch/smoke/tgz/
	rm -f hutch/smoke/tgz/hutch-full_*.tar.gz
	$(DOCKER_RUN) --rm -it -p 4884:4884 babelouest/hutch-smoke

hutch-rpm-smoke:
	cp hutch/hutch-full_*.tar.gz hutch/smoke/rpm/
	$(DOCKER_BUILD) -t babelouest/hutch-smoke --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) --build-arg HUTCH_VERSION=$(HUTCH_VERSION) --build-arg RPMI=$(RPMI) hutch/smoke/rpm/
	rm -f hutch/smoke/rpm/hutch-full_*.tar.gz
	$(DOCKER_RUN) --rm -it -p 4884:4884 babelouest/hutch-smoke

hutch-debian-oldstable: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) debian-oldstable
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-debian-oldstable-test: hutch-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) hutch-deb-test

hutch-debian-oldstable-smoke: hutch-debian-oldstable
	$(MAKE) debian-oldstable
	$(MAKE) hutch-deb-smoke

hutch-debian-stable: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) debian-stable
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-debian-stable-test: hutch-debian-stable
	$(MAKE) debian-stable
	$(MAKE) hutch-deb-test

hutch-debian-stable-smoke: hutch-debian-stable
	$(MAKE) debian-stable
	$(MAKE) hutch-deb-smoke

hutch-debian-testing: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) debian-testing
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-debian-testing-test: hutch-debian-testing
	$(MAKE) debian-testing
	$(MAKE) hutch-deb-test

hutch-debian-testing-smoke: hutch-debian-testing
	$(MAKE) debian-testing
	$(MAKE) hutch-deb-smoke

hutch-ubuntu-latest: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) ubuntu-latest
	$(MAKE) hutch-deb
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-ubuntu-latest-test: hutch-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) hutch-deb-test

hutch-ubuntu-latest-smoke: hutch-ubuntu-latest
	$(MAKE) ubuntu-latest
	$(MAKE) hutch-deb-smoke

hutch-ubuntu-lts: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hutch-deb; \
		xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%; \
	fi

hutch-ubuntu-lts-test: hutch-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hutch-deb-test; \
	fi

hutch-ubuntu-lts-smoke: hutch-ubuntu-lts
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) hutch-deb-smoke; \
	fi

hutch-alpine: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) alpine
	$(MAKE) hutch-tgz
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-alpine-test: hutch-alpine
	$(MAKE) alpine
	$(MAKE) hutch-tgz-test

hutch-alpine-smoke: hutch-alpine
	$(MAKE) alpine
	$(MAKE) hutch-tgz-smoke

hutch-fedora: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) fedora
	$(MAKE) hutch-rpm RPMI=yum
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-fedora-test: hutch-fedora
	$(MAKE) fedora
	$(MAKE) hutch-rpm-test RPMI=yum

hutch-fedora-smoke: hutch-fedora
	$(MAKE) fedora
	$(MAKE) hutch-rpm-smoke RPMI=yum

hutch-centos: yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	$(MAKE) centos
	$(MAKE) hutch-rpm RPMI=yum
	xargs -a ./hutch/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=hutch TAG=$(HUTCH_VERSION) PATTERN=./hutch/%

hutch-centos-test: hutch-centos
	$(MAKE) centos
	$(MAKE) hutch-rpm-test RPMI=yum

hutch-centos-smoke: hutch-centos
	$(MAKE) centos
	$(MAKE) hutch-rpm-smoke RPMI=yum

hutch-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libmicrohttpd-dev libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libgnutls28-dev pkg-config; \
	fi

hutch-local-deb: hutch-install-dependencies yder-source orcania-source hoel-source ulfius-source rhonabwy-source iddawc-source hutch-source
	mkdir -p build/orcania build/yder build/ulfius build/hoel build/rhonabwy build/iddawc build/hutch
	# package orcania
	#wget https://github.com/babelouest/orcania/archive/v$(ORCANIA_VERSION).tar.gz -O build/v$(ORCANIA_VERSION).tar.gz
	tar xf orcania/orcania.tar.gz -C build/orcania/ --strip 1
	rm -f build/v$(ORCANIA_VERSION).tar.gz
	( cd build/orcania && \
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
	#wget https://github.com/babelouest/yder/archive/v$(YDER_VERSION).tar.gz -O build/v$(YDER_VERSION).tar.gz
	tar xf yder/yder.tar.gz -C build/yder/ --strip 1
	rm -f build/v$(YDER_VERSION).tar.gz
	( cd build/yder && \
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
	#wget https://github.com/babelouest/ulfius/archive/v$(ULFIUS_VERSION).tar.gz -O build/v$(ULFIUS_VERSION).tar.gz
	tar xf ulfius/ulfius.tar.gz -C build/ulfius/ --strip 1
	rm -f build/v$(ULFIUS_VERSION).tar.gz
	( cd build/ulfius && \
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
	#wget https://github.com/babelouest/hoel/archive/v$(HOEL_VERSION).tar.gz -O build/v$(HOEL_VERSION).tar.gz
	tar xf hoel/hoel.tar.gz -C build/hoel/ --strip 1
	rm -f build/v$(HOEL_VERSION).tar.gz
	( cd build/hoel && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../hutch/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package rhonabwy
	#wget https://github.com/babelouest/rhonabwy/archive/v$(RHONABWY_VERSION).tar.gz -O build/v$(RHONABWY_VERSION).tar.gz
	tar xf rhonabwy/rhonabwy.tar.gz -C build/rhonabwy/ --strip 1
	( cd build/rhonabwy && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp librhonabwy_*.deb ../../../glewlwyd/librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package iddawc
	#wget https://github.com/babelouest/iddawc/archive/v$(IDDAWC_VERSION).tar.gz -O build/v$(IDDAWC_VERSION).tar.gz
	tar xf iddawc/iddawc.tar.gz -C build/iddawc/ --strip 1
	( cd build/iddawc && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp libiddawc_*.deb ../../../glewlwyd/libiddawc_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package hutch
	#wget https://github.com/babelouest/hutch/archive/v$(HUTCH_VERSION).tar.gz -O build/v$(HUTCH_VERSION).tar.gz
	tar xf hutch/v$(HUTCH_VERSION).tar.gz -C build/hutch
	( cd build/hutch && \
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
	$(MAKE) hutch-source-signed
	$(MAKE) hutch-debian-oldstable
	$(MAKE) hutch-debian-stable
	$(MAKE) hutch-debian-testing
	$(MAKE) hutch-ubuntu-latest
	$(MAKE) hutch-ubuntu-lts
	$(MAKE) hutch-alpine
	$(MAKE) hutch-fedora
	$(MAKE) hutch-centos

hutch-test:
	$(MAKE) hutch-debian-oldstable-test
	$(MAKE) hutch-debian-stable-test
	$(MAKE) hutch-debian-testing-test
	$(MAKE) hutch-ubuntu-latest-test
	$(MAKE) hutch-ubuntu-lts-test
	$(MAKE) hutch-alpine-test
	$(MAKE) hutch-fedora-test
	$(MAKE) hutch-centos-test

hutch-clean: clean-base
	rm -f hutch/*.tar.gz hutch/*.zip hutch/*.deb hutch/*.rpm hutch/packages hutch/*.sig hutch/*.gpg
	-docker rmi -f babelouest/hutch

angharad-source: angharad/angharad.tar.gz

angharad-source-signed: angharad/angharad.tar.gz angharad/angharad.zip
	@if [ "$(SIGN_ASSET)" = "1" ]; then \
		gpg --detach-sign --yes angharad/angharad.tar.gz || true; \
		gpg --detach-sign --yes angharad/angharad.zip || true; \
		if [ "$(GITHUB_UPLOAD)" = "1" ]; then \
			if [ -f angharad/angharad.tar.gz.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=angharad tag=v$(ANGHARAD_VERSION) filename=angharad/angharad.tar.gz.sig; \
			fi; \
			if [ -f angharad/angharad.zip.sig ]; then \
				./upload-github-release-asset.sh github_api_token=$(GITHUB_TOKEN) owner=$(GITHUB_USER) repo=angharad tag=v$(ANGHARAD_VERSION) filename=angharad/angharad.zip.sig; \
			fi; \
		fi \
	fi;

angharad/angharad.tar.gz:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O angharad/angharad.tar.gz https://github.com/babelouest/angharad/archive/v$(ANGHARAD_VERSION).tar.gz; \
	else \
		tar --exclude='angharad/webapp-src/node_modules*' --exclude 'angharad/.git/*' --exclude 'angharad/src/benoic/.git/*' --exclude 'angharad/src/carleon/.git/*' --exclude 'angharad/src/gareth/.git/*' -cvzf angharad/angharad.tar.gz $(ANGHARAD_SRC); \
	fi

angharad/angharad.zip:
	@if [ "$(REMOTE)" = "1" ]; then \
		wget -O angharad/angharad.zip https://github.com/babelouest/angharad/archive/v$(ANGHARAD_VERSION).zip; \
	fi

angharad-deb:
	$(DOCKER_BUILD) -t babelouest/angharad --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg ANGHARAD_VERSION=$(ANGHARAD_VERSION) --build-arg BENOIC_VERSION=$(BENOIC_VERSION) --build-arg CARLEON_VERSION=$(CARLEON_VERSION) --build-arg GARETH_VERSION=$(GARETH_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) angharad/build/deb/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/angharad

angharad-tgz:
	$(DOCKER_BUILD) -t babelouest/angharad --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg ANGHARAD_VERSION=$(ANGHARAD_VERSION) --build-arg BENOIC_VERSION=$(BENOIC_VERSION) --build-arg CARLEON_VERSION=$(CARLEON_VERSION) --build-arg GARETH_VERSION=$(GARETH_VERSION) --build-arg RHONABWY_VERSION=$(RHONABWY_VERSION) --build-arg IDDAWC_VERSION=$(IDDAWC_VERSION) angharad/build/tgz/
	$(DOCKER_RUN) --rm -v $(shell pwd)/:/share babelouest/angharad

angharad-debian-stable: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source angharad-source
	$(MAKE) debian-stable
	$(MAKE) angharad-deb
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-debian-testing: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source angharad-source
	$(MAKE) debian-testing
	$(MAKE) angharad-deb
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-ubuntu-latest: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source angharad-source
	$(MAKE) ubuntu-latest
	$(MAKE) angharad-deb
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-ubuntu-lts: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source angharad-source
	$(MAKE) ubuntu-latest
	$(MAKE) ubuntu-lts
	@if [ "$(shell docker images -q ubuntu:latest)" != "$(shell docker images -q ubuntu:rolling)" ]; then \
		$(MAKE) angharad-deb; \
		xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%; \
	fi

angharad-alpine: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source angharad-source
	$(MAKE) alpine
	$(MAKE) angharad-tgz
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-install-dependencies:
	@if [ "$(LOCAL_UPDATE_SYSTEM)" = "1" ]; then \
		# install dependencies \
		sudo apt update && sudo apt upgrade -y; \
		sudo apt-get install -y libmicrohttpd-dev libjansson-dev libsystemd-dev libmariadbclient-dev libsqlite3-dev libconfig-dev libopenzwave1.5-dev libmpdclient-dev libcurl4-gnutls-dev g++ pkg-config; \
	fi

angharad-local-deb: orcania-source yder-source hoel-source ulfius-source rhonabwy-source iddawc-source angharad-source angharad-install-dependencies
	mkdir -p build/orcania build/yder build/ulfius build/hoel build/rhonabwy build/iddawc build/angharad
	# package orcania
	tar xf orcania/orcania.tar.gz -C build/orcania/ --strip 1
	( cd build/orcania && \
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
	tar xf yder/yder.tar.gz -C build/yder/ --strip 1
	( cd build/yder && \
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
	tar xf ulfius/ulfius.tar.gz -C build/ulfius/ --strip 1
	( cd build/ulfius && \
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
	tar xf hoel/hoel.tar.gz -C build/hoel/ --strip 1
	( cd build/hoel && \
	mkdir build && \
	cd build && \
	cmake -DWITH_PGSQL=off .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off .. && \
	make package; \
	cp libhoel_*.deb ../../../angharad/libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package rhonabwy
	tar xf rhonabwy/rhonabwy.tar.gz -C build/rhonabwy/ --strip 1
	( cd build/rhonabwy && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp librhonabwy_*.deb ../../../angharad/librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package iddawc
	tar xf iddawc/iddawc.tar.gz -C build/iddawc/ --strip 1
	( cd build/iddawc && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	sudo make install && \
	rm -rf * && \
	cmake -DINSTALL_HEADER=off .. && \
	make package; \
	cp libiddawc_*.deb ../../../angharad/libiddawc_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	# package angharad
	tar xf angharad/angharad.tar.gz -C build/angharad/ --strip 1
	@if [ "$(REMOTE)" = "1" ]; then \
		mkdir -p angharad/src/benoic angharad/src/carleon angharad/src/gareth; \
		tar xf benoic/benoic.tar.gz -C build/angharad/src/benoic/ --strip 1; \
		tar xf carleon/carleon.tar.gz -C build/angharad/src/carleon/ --strip 1; \
		tar xf gareth/gareth.tar.gz -C build/angharad/src/gareth/ --strip 1; \
	fi
	(cd build/angharad && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make package; \
	cp angharad_*.deb ../../../angharad/angharad_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb )

	( cd angharad && tar cvz liborcania_$(ORCANIA_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libyder_$(YDER_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libulfius_$(ULFIUS_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libhoel_$(HOEL_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb librhonabwy_$(RHONABWY_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb libiddawc_$(IDDAWC_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb angharad_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb -f angharad-full_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz )
	rm -rf build/*
	echo angharad_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.deb > ./angharad/packages
	echo angharad-full_$(ANGHARAD_VERSION)_$(LOCAL_ID)_$(LOCAL_RELEASE)_`uname -m`.tar.gz >> ./angharad/packages
	xargs -a ./angharad/packages -I% $(MAKE) upload-asset GITHUB_UPLOAD=$(GITHUB_UPLOAD) GITHUB_TOKEN=$(GITHUB_TOKEN) GITHUB_USER=$(GITHUB_USER) REPO=angharad TAG=$(ANGHARAD_VERSION) PATTERN=./angharad/%

angharad-build:
	$(MAKE) angharad-source-signed
	$(MAKE) angharad-debian-stable
	$(MAKE) angharad-debian-testing
	$(MAKE) angharad-ubuntu-latest
	$(MAKE) angharad-ubuntu-lts
	$(MAKE) angharad-alpine

angharad-clean: clean-base
	rm -f angharad/*.tar.gz angharad/*.zip angharad/*.deb angharad/packages angharad/*.sig angharad/*.gpg
	-docker rmi -f babelouest/angharad
