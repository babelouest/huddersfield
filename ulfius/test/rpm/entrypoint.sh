#!/bin/bash

set -e

ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz

if [ -f $ULFIUS_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  
  tar xvf /share/ulfius/ulfius-dev-full_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz
  yum install -y liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm
  yum install -y libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm
  yum install -y libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm

  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  cd /opt/ulfius/test

  make u_map core framework websocket LIBS="-lc -lorcania -lulfius -lyder -ljansson -lgnutls -lcheck -pthread -lrt -lm -lsubunit"
  
  ./u_map
  ./core
  ./framework
  ./websocket
  
  echo "$(date -R) libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm test complete success" >> /share/summary.log
else
  echo "File $ULFIUS_ARCHIVE not present" && false
fi
