#
# Taliesin media server
#
# Makefile used to build docker images
#
# Copyright 2017-2018 Nicolas Mora <mail@babelouest.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU GENERAL PUBLIC LICENSE
# License as published by the Free Software Foundation;
# version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU GENERAL PUBLIC LICENSE for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

TARGET_SRC=src
TARGET_X86_64_CUSTOM=x86_64_custom
TARGET_X86_64_SQLITE3_NOAUTH=x86_64_sqlite3_noauth

GITHUB_TOKEN=$(shell cat ../../GITHUB_TOKEN)

ifeq (($(GITHUB_TOKEN)),"")
	AUTH_HEADER=
else
	AUTH_HEADER=-H "Authorization: token $(GITHUB_TOKEN)"
endif

TALIESIN_VERSION=$(shell curl $(AUTH_HEADER) -s https://api.github.com/repos/babelouest/taliesin/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
LIBJWT_VERSION=1.9.0

build-quickstart-src:
	docker build -t babelouest/taliesin_x86_64:src --build-arg TALIESIN_VERSION=$(TALIESIN_VERSION) --build-arg LIBJWT_VERSION=$(LIBJWT_VERSION) $(TARGET_SRC)/

build-quickstart-x86_64_custom:
	docker build -t babelouest/taliesin_x86_64:custom $(TARGET_X86_64_CUSTOM)/

build-quickstart-x86_64_sqlite_noauth:
	docker build -t babelouest/taliesin_x86_64:sqlite_noauth $(TARGET_X86_64_SQLITE3_NOAUTH)

build-all: build-quickstart-src build-quickstart-x86_64_custom build-quickstart-x86_64_sqlite_noauth
