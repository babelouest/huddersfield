#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz
YDER_ARCHIVE=/share/yder/yder.tar.gz
ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz
HOEL_ARCHIVE=/share/hoel/hoel.tar.gz
HUTCH_ARCHIVE=/share/hutch/hutch.tar.gz

if [ -f $ORCANIA_ARCHIVE ] && [ -f $YDER_ARCHIVE ] && [ -f $ULFIUS_ARCHIVE ] && [ -f $HOEL_ARCHIVE ] && [ -f $HUTCH_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  HUTCH_VERSION=$(cat /opt/HUTCH_VERSION)
  
  mkdir /opt/orcania/

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  mkdir /opt/orcania/build

  cd /opt/orcania/build

  cmake ..

  make install

  make package

  cp liborcania-dev_$ORCANIA_VERSION.deb /share/hutch/liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp liborcania_$ORCANIA_VERSION.deb /opt/liborcania_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  mkdir /opt/yder/

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1

  mkdir /opt/yder/build

  cd /opt/yder/build

  cmake ..

  make install

  make package

  cp libyder-dev_$YDER_VERSION.deb /share/hutch/libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp libyder_$YDER_VERSION.deb /opt/libyder_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  mkdir /opt/ulfius/build

  cd /opt/ulfius/build

  cmake ..

  make install

  make package

  cp libulfius-dev_$ULFIUS_VERSION.deb /share/hutch/libulfius-dev_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp libulfius_$ULFIUS_VERSION.deb /opt/libulfius_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  mkdir /opt/hoel/

  tar -zxvf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  mkdir /opt/hoel/build

  cd /opt/hoel/build

  cmake ..

  make install

  make package

  cp libhoel-dev_$HOEL_VERSION.deb /share/hutch/libhoel-dev_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp libhoel_$HOEL_VERSION.deb /opt/libhoel_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  mkdir /opt/hutch/

  tar -zxvf $HUTCH_ARCHIVE -C /opt/hutch --strip 1

  mkdir /opt/hutch/build
  
  cd /opt/hutch/build
  
  cmake ..
  
  make package 
  
  cp hutch_$HUTCH_VERSION.deb /share/hutch/hutch_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  cp hutch_$HUTCH_VERSION.deb /opt/hutch_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  echo hutch_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb > /share/hutch/packages
  
  rm -rf *
  
  cmake ..
  
  make package 
  
  cp hutch_$HUTCH_VERSION.deb /share/hutch/hutch-dev_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  
  cd /opt
  
  tar cvz liborcania_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libyder_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libulfius_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libhoel_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          hutch_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          -f /share/hutch/hutch-full_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz
  echo hutch-full_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz >> /share/hutch/packages
  
  echo "$(date -R) hutch-full_${HUTCH_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz build success" >> /share/summary.log
else
  echo "Files $ORCANIA_ARCHIVE or $YDER_ARCHIVE or $ULFIUS_ARCHIVE or $HOEL_ARCHIVE or $HUTCH_ARCHIVE not present" && false
fi
