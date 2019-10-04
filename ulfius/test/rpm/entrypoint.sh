#!/bin/bash

set -e

ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz

if [ -f $ULFIUS_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  
  tar xvf /share/ulfius/ulfius-dev-full_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.tar.gz
  rpm --install liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm

  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  cd /opt/ulfius/test

  make u_map core framework websocket LIBS="-lc -lorcania -lulfius -lyder -ljansson -lgnutls -pthread $(pkg-config --libs check)"
  
  ./u_map
  ./core
  ./framework
  ./websocket
  
  echo "$(date -R) libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm test complete success" >> /share/summary.log
else
  echo "File $ULFIUS_ARCHIVE not present" && false
fi
