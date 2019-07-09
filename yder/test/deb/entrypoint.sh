#!/bin/bash

set -e

YDER_ARCHIVE=/share/yder/yder.tar.gz

if [ -f $YDER_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  
  dpkg -i /share/yder/liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i /share/yder/libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  mkdir /opt/yder

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1
  
  cd /opt/yder/test
  
  make yder_test
  
  ./yder_test
  
  echo "$(date -R) libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb test complete success" >> /share/summary.log
else
  echo "File $YDER_ARCHIVE not present" && false
fi
