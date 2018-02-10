# package builder root Makefile
# build all packages for all environments

clean: orcania-clean yder-clean

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
	docker build -t babelouest/orcania orcania/deb/
	docker run -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-tgz:
	docker build -t babelouest/orcania orcania/tgz/
	docker run -v $(shell pwd)/orcania/:/share babelouest/orcania

orcania-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) orcania-deb

orcania-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) orcania-deb

orcania-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) orcania-deb

orcania-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) orcania-deb

orcania-alpine: 
	$(MAKE) alpine
	$(MAKE) orcania-tgz

orcania-build:
	$(MAKE) orcania-debian-stable
	$(MAKE) orcania-debian-testing
	$(MAKE) orcania-ubuntu-latest
	$(MAKE) orcania-ubuntu-lts
	$(MAKE) orcania-alpine

orcania-clean:
	rm -f orcania/*.tar.gz orcania/*.deb
	docker rmi -f babelouest/orcania babelouest/deb babelouest/tgz

yder-deb:
	docker build -t babelouest/yder yder/deb/
	docker run -v $(shell pwd)/yder/:/share babelouest/yder

yder-tgz:
	docker build -t babelouest/yder yder/tgz/
	docker run -v $(shell pwd)/yder/:/share babelouest/yder

yder-debian-stable: 
	$(MAKE) debian-stable
	$(MAKE) yder-deb

yder-debian-testing: 
	$(MAKE) debian-testing
	$(MAKE) yder-deb

yder-ubuntu-latest: 
	$(MAKE) ubuntu-latest
	$(MAKE) yder-deb

yder-ubuntu-lts: 
	$(MAKE) ubuntu-lts
	$(MAKE) yder-deb

yder-alpine: 
	$(MAKE) alpine
	$(MAKE) yder-tgz

yder-build:
	$(MAKE) yder-debian-stable
	$(MAKE) yder-debian-testing
	$(MAKE) yder-ubuntu-latest
	$(MAKE) yder-ubuntu-lts
	$(MAKE) yder-alpine

yder-clean:
	rm -f yder/*.tar.gz yder/*.deb
	docker rmi -f babelouest/yder babelouest/deb babelouest/tgz
