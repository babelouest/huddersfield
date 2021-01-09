#!/bin/bash

set -e

IDDAWC_ARCHIVE=/share/iddawc/iddawc.tar.gz

if [ -f $IDDAWC_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  
  tar xvf /share/iddawc/iddawc-dev-full_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  tar xvf liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf libiddawc-dev_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1

  mkdir /opt/iddawc/

  tar -zxf $IDDAWC_ARCHIVE -C /opt/iddawc --strip 1

  cd /opt/iddawc/test

  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 core.c -o core -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 implicit.c -o implicit -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 id_token.c -o id_token -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 token.c -o token -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 load_config.c -o load_config -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 load_userinfo.c -o load_userinfo -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 flow.c -o flow -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius
  
  ./core
  ./implicit
  ./id_token
  ./token
  ./load_config
  ./load_userinfo
  ./flow
  
  echo "$(date -R) iddawc-dev-full_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $IDDAWC_ARCHIVE not present" && false
fi
