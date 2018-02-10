# package builder root Makefile
# build all packages for all environments

ORCANIA_VERSION=1.2.0-b.3
YDER_VERSION=1.2.0-b.2
ULFIUS_VERSION=2.3.0-b.3
HOEL_VERSION=1.4.0-b.3
GLEWLWYD_VERSION=1.3.2-b
TALIESIN_VERSION=1.0.12
HUTCH_VERSION=1.1

CODE_DEBIAN_STABLE=stretch
CODE_DEBIAN_TESTING=buster
CODE_UBUNTU_LATEST=artful
CODE_UBUNTU_LTS=xenial
CODE_ALPINE_STABLE=3.7

all: build-debian-stable build-debian-testing build-ubuntu-latest build-ubuntu-lts build-alpine

build-debian-stable: orcania-debian-stable yder-debian-stable ulfius-debian-stable hoel-debian-stable

build-debian-testing: orcania-debian-testing yder-debian-testing ulfius-debian-testing hoel-debian-testing

build-ubuntu-latest: orcania-ubuntu-latest yder-ubuntu-latest ulfius-ubuntu-latest hoel-ubuntu-latest

build-ubuntu-lts: orcania-ubuntu-lts yder-ubuntu-lts ulfius-ubuntu-lts hoel-ubuntu-lts

build-alpine: orcania-alpine yder-alpine ulfius-alpine hoel-alpine

clean: orcania-clean yder-clean ulfius-clean hoel-clean
	-docker rmi -f babelouest/deb babelouest/tgz

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

orcania-clean:
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

yder-clean:
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

ulfius-clean:
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

hoel-clean:
	rm -f hoel/*.tar.gz hoel/*.deb
	-docker rmi -f babelouest/hoel
