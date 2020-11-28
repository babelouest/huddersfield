#!/bin/bash

set -e

HOEL_ARCHIVE=/share/hoel/hoel.tar.gz

if [ -f $HOEL_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  
  tar xvf /share/hoel/hoel-dev-full_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).tar.gz
  rpm --install liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  rpm --install libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  rpm --install libhoel-dev_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/hoel/

  tar -zxvf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  cd /opt/hoel/test

  make core LIBS="-lc -lorcania -lhoel -lyder -ljansson -pthread $(pkg-config --libs check)"
  
  sqlite3 /tmp/test.db < test.sqlite3.sql

  ./core
  
  echo "$(date -R) libhoel-dev_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm test complete success" >> /share/summary.log
else
  echo "File $HOEL_ARCHIVE not present" && false
fi
