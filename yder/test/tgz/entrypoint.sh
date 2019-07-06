#!/bin/bash

set -e

YDER_ARCHIVE=/share/yder/yder.tar.gz

if [ -f $YDER_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  
  tar xvf /share/orcania/liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz -C /usr/ --strip 1
  tar xvf /share/yder/libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz
  
  mv /usr/lib64/liborcania* /usr/lib
  mv /usr/lib64/libyder* /usr/lib

  mkdir /opt/yder

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1
  
  cd /opt/yder/test
  
  make yder_test
  
  ./yder_test
else
  echo "File $YDER_ARCHIVE not present" && false
fi
