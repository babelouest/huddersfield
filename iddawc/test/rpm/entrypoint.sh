#!/bin/bash

set -e

IDDAWC_ARCHIVE=/share/iddawc/iddawc.tar.gz

if [ -f $IDDAWC_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  
  tar xvf /share/iddawc/iddawc-dev-full_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.tar.gz
  rpm --install liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install librhonabwy-dev_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libiddawc-dev_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm

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
  
  echo "$(date -R) iddawc-dev-full_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $IDDAWC_ARCHIVE not present" && false
fi
