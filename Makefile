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
#
# Copyright 2014-2015 Nicolas Mora <mail@babelouest.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the MIT License
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU GENERAL PUBLIC LICENSE for more details.
#

ORCANIA_VERSION=1.2.0-b.4
YDER_VERSION=1.2.0-b.4
ULFIUS_VERSION=2.3.0-b.5
HOEL_VERSION=1.4.0-b.6
GLEWLWYD_VERSION=1.3.2-b.5
TALIESIN_VERSION=1.0.12-b
HUTCH_VERSION=1.1
LIBJWT_VERSION=1.9.0

CODE_DEBIAN_STABLE=stretch
CODE_DEBIAN_TESTING=buster
CODE_UBUNTU_LATEST=artful
CODE_UBUNTU_LTS=xenial
CODE_ALPINE_STABLE=3.7

all: build-debian-stable build-debian-testing build-ubuntu-latest build-ubuntu-lts build-alpine

build-debian-stable: orcania-debian-stable yder-debian-stable ulfius-debian-stable hoel-debian-stable glewlwyd-debian-stable taliesin-debian-stable

build-debian-testing: orcania-debian-testing yder-debian-testing ulfius-debian-testing hoel-debian-testing glewlwyd-debian-testing taliesin-debian-testing

build-ubuntu-latest: orcania-ubuntu-latest yder-ubuntu-latest ulfius-ubuntu-latest hoel-ubuntu-latest glewlwyd-ubuntu-latest taliesin-ubuntu-latest

build-ubuntu-lts: orcania-ubuntu-lts yder-ubuntu-lts ulfius-ubuntu-lts hoel-ubuntu-lts glewlwyd-ubuntu-lts

build-alpine: orcania-alpine yder-alpine ulfius-alpine hoel-alpine glewlwyd-alpine taliesin-alpine

clean-base:
	-docker rmi -f babelouest/deb babelouest/tgz

clean: orcania-clean yder-clean ulfius-clean hoel-clean glewlwyd-clean taliesin-clean clean-base clean-no-tag-images

clean-no-tag-images:
	-docker rmi -f $(shell docker images -f "dangling=true" -q)

debian-stable:
	docker build -t babelouest/deb docker-base/debian-stable/

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
	docker run -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-tgz:
	docker build -t babelouest/orcania --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) orcania/tgz/
	docker run -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) orcania-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)

orcania-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) orcania-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)

orcania-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) orcania-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)

orcania-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) orcania-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)

orcania-alpine: 
	$(MAKE) alpine
	$(MAKE) orcania-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)

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
	docker run -v $(shell pwd)/yder/:/share babelouest/yder

yder-tgz:
	docker build -t babelouest/yder --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) yder/tgz/
	docker run -v $(shell pwd)/yder/:/share babelouest/yder

yder-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) yder-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)

yder-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) yder-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)

yder-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) yder-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)

yder-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) yder-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)

yder-alpine: 
	$(MAKE) alpine
	$(MAKE) yder-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)

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
	docker run -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-tgz:
	docker build -t babelouest/ulfius --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) ulfius/tgz/
	docker run -v $(shell pwd)/ulfius/:/share babelouest/ulfius

ulfius-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) ulfius-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)

ulfius-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) ulfius-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)

ulfius-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) ulfius-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)

ulfius-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) ulfius-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)

ulfius-alpine: 
	$(MAKE) alpine
	$(MAKE) ulfius-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)

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
	docker run -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-tgz:
	docker build -t babelouest/hoel --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) hoel/tgz/
	docker run -v $(shell pwd)/hoel/:/share babelouest/hoel

hoel-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) hoel-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)

hoel-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) hoel-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)

hoel-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) hoel-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)

hoel-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) hoel-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)

hoel-alpine: 
	$(MAKE) alpine
	$(MAKE) hoel-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)

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
	docker run -v $(shell pwd)/glewlwyd/:/share babelouest/glewlwyd

glewlwyd-tgz:
	docker build -t babelouest/glewlwyd --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg GLEWLWYD_VERSION=$(GLEWLWYD_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) glewlwyd/tgz/
	docker run -v $(shell pwd)/glewlwyd/:/share babelouest/glewlwyd

glewlwyd-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) glewlwyd-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)

glewlwyd-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) glewlwyd-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)

glewlwyd-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) glewlwyd-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)

glewlwyd-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) glewlwyd-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LTS)

glewlwyd-alpine: 
	$(MAKE) alpine
	$(MAKE) glewlwyd-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)

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
	docker run -v $(shell pwd)/taliesin/:/share babelouest/taliesin

taliesin-tgz:
	docker build -t babelouest/taliesin --build-arg ORCANIA_VERSION=$(ORCANIA_VERSION) --build-arg YDER_VERSION=$(YDER_VERSION) --build-arg HOEL_VERSION=$(HOEL_VERSION) --build-arg ULFIUS_VERSION=$(ULFIUS_VERSION) --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) --build-arg DISTRIB=$(DISTRIB) --build-arg CODE=$(CODE) taliesin/tgz/
	docker run -v $(shell pwd)/taliesin/:/share babelouest/taliesin

taliesin-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) taliesin-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_STABLE)

taliesin-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) taliesin-deb DISTRIB=Debian CODE=$(CODE_DEBIAN_TESTING)

taliesin-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) taliesin-deb DISTRIB=Ubuntu CODE=$(CODE_UBUNTU_LATEST)

taliesin-alpine: 
	$(MAKE) alpine
	$(MAKE) taliesin-tgz DISTRIB=Alpine CODE=$(CODE_ALPINE_STABLE)

taliesin-build:
	$(MAKE) taliesin-debian-stable
	$(MAKE) taliesin-debian-testing
	$(MAKE) taliesin-ubuntu-latest
	$(MAKE) taliesin-alpine

taliesin-clean: clean-base
	rm -f taliesin/*.tar.gz taliesin/*.deb
	-docker rmi -f babelouest/taliesin
