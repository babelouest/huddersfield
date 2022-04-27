#!/bin/bash

set -e

YDER_ARCHIVE=/share/yder/yder.tar.gz

if [ -f $YDER_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  
  tar xvf /share/yder/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/yder/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  
  mkdir /opt/yder

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1
  
  cd /opt/yder/test
  
  make yder_test Y_DISABLE_JOURNALD=1
  
  ./yder_test
  
  echo "$(date -R) libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $YDER_ARCHIVE not present" && false
fi
