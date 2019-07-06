#!/bin/bash

set -e

ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz

if [ -f $ULFIUS_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  
  tar xvf /share/ulfius/ulfius-dev-full_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  tar xvf  liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf  libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf  libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1

  mv /usr/lib64/liborcania* /usr/lib
  mv /usr/lib64/libyder* /usr/lib
  mv /usr/lib64/libulfius* /usr/lib

  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  cd /opt/ulfius/test

  make u_map core framework websocket
  
  ./u_map
  ./core
  #./framework # fails on alpine
  ./websocket
else
  echo "File $ULFIUS_ARCHIVE not present" && false
fi
