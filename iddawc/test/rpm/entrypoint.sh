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

  ./cert/create-cert.sh

  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 core.c -o core -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 implicit.c -o implicit -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 id_token.c -o id_token -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 token.c -o token -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 load_config.c -o load_config -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 load_userinfo.c -o load_userinfo -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 flow.c -o flow -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 introspection.c -o introspection -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 revocation.c -o revocation -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 registration.c -o registration -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 dpop.c -o dpop -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 api_request.c -o api_request -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 device.c -o device -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 par.c -o par -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 session.c -o session -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  gcc -Wall -D_REENTRANT -I../include -DDEBUG -g -O0 rar.c -o rar -lc -lorcania -liddawc -lrhonabwy -ljansson -lyder $(pkg-config --libs check) -lulfius -lgnutls
  
  ./core
  ./implicit
  ./id_token
  ./token
  ./load_config
  ./load_userinfo
  ./flow
  ./introspection
  ./revocation
  ./registration
  ./dpop
  ./api_request
  ./device
  ./par
  ./session
  ./rar
  
  echo "$(date -R) iddawc-dev-full_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $IDDAWC_ARCHIVE not present" && false
fi
