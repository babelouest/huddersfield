#!/bin/bash

set -e

YDER_ARCHIVE=/share/yder/yder.tar.gz

if [ -f $YDER_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  
  rpm --install /share/yder/liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  rpm --install /share/yder/libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/yder

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1
  
  cd /opt/yder/test
  
  make yder_test
  
  ./yder_test
  
  echo "$(date -R) libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm test complete success" >> /share/summary.log
else
  echo "File $YDER_ARCHIVE not present" && false
fi
