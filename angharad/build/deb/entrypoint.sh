#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz
YDER_ARCHIVE=/share/yder/yder.tar.gz
ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz
HOEL_ARCHIVE=/share/hoel/hoel.tar.gz
RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz
IDDAWC_ARCHIVE=/share/iddawc/iddawc.tar.gz
ANGHARAD_ARCHIVE=/share/angharad/angharad.tar.gz
BENOIC_ARCHIVE=/share/angharad/benoic.tar.gz
CARLEON_ARCHIVE=/share/angharad/carleon.tar.gz
GARETH_ARCHIVE=/share/angharad/gareth.tar.gz

if [ -f $ORCANIA_ARCHIVE ] && [ -f $YDER_ARCHIVE ] && [ -f $ULFIUS_ARCHIVE ] && [ -f $HOEL_ARCHIVE ] && [ -f $RHONABWY_ARCHIVE ] && [ -f $IDDAWC_ARCHIVE ] && [ -f $ANGHARAD_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  ANGHARAD_VERSION=$(cat /opt/ANGHARAD_VERSION)
  
  # Orcania
  mkdir /opt/orcania/

  tar -zxf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  mkdir /opt/orcania/build

  cd /opt/orcania/build

  cmake ..

  make install

  make package

  cp liborcania-dev_$ORCANIA_VERSION.deb /share/angharad/liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp liborcania_$ORCANIA_VERSION.deb /opt/liborcania_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  # Yder
  mkdir /opt/yder/

  tar -zxf $YDER_ARCHIVE -C /opt/yder --strip 1

  mkdir /opt/yder/build

  cd /opt/yder/build

  cmake ..

  make install

  make package

  cp libyder-dev_$YDER_VERSION.deb /share/angharad/libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp libyder_$YDER_VERSION.deb /opt/libyder_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  # Ulfius
  mkdir /opt/ulfius/

  tar -zxf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  mkdir /opt/ulfius/build

  cd /opt/ulfius/build

  cmake ..

  make install

  make package

  cp libulfius-dev_$ULFIUS_VERSION.deb /share/angharad/libulfius-dev_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp libulfius_$ULFIUS_VERSION.deb /opt/libulfius_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  # Hoel
  mkdir /opt/hoel/

  tar -zxf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  mkdir /opt/hoel/build

  cd /opt/hoel/build

  cmake -DWITH_PGSQL=off ..

  make install

  make package

  cp libhoel-dev_$HOEL_VERSION.deb /share/angharad/libhoel-dev_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DWITH_PGSQL=off -DINSTALL_HEADER=off ..

  make package

  cp libhoel_$HOEL_VERSION.deb /opt/libhoel_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  # Rhonabwy
  mkdir /opt/rhonabwy/

  tar -zxf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  mkdir /opt/rhonabwy/build

  cd /opt/rhonabwy/build

  cmake ..

  make install

  make package

  cp librhonabwy-dev_$RHONABWY_VERSION.deb /share/angharad/librhonabwy-dev_${RHONABWY_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DINSTALL_HEADER=off ..

  make package

  cp librhonabwy_$RHONABWY_VERSION.deb /opt/librhonabwy_${RHONABWY_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  # Iddawc
  mkdir /opt/iddawc/

  tar -zxf $IDDAWC_ARCHIVE -C /opt/iddawc --strip 1

  mkdir /opt/iddawc/build

  cd /opt/iddawc/build

  cmake -DBUILD_IDWCC=OFF ..

  make install

  make package

  cp libiddawc-dev_$IDDAWC_VERSION.deb /share/angharad/libiddawc-dev_${IDDAWC_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  rm -rf *

  cmake -DBUILD_IDWCC=OFF -DINSTALL_HEADER=off ..

  make package

  cp libiddawc_$IDDAWC_VERSION.deb /opt/libiddawc_${IDDAWC_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  # Angharad
  mkdir /opt/angharad/

  tar -zxf $ANGHARAD_ARCHIVE -C /opt/angharad --strip 1

  if [ -f $BENOIC_ARCHIVE ]; then
    tar -zxf $BENOIC_ARCHIVE -C /opt/angharad/benoic --strip 1;
  fi

  if [ -f $CARLEON_ARCHIVE ]; then
    tar -zxf $CARLEON_ARCHIVE -C /opt/angharad/carleon --strip 1;
  fi

  if [ -f $GARETH_ARCHIVE ]; then
    tar -zxf $GARETH_ARCHIVE -C /opt/angharad/gareth --strip 1;
  fi

  mkdir /opt/angharad/build
  
  cd /opt/angharad/build
  
  cmake ..
  
  make package 
  
  cp angharad_$ANGHARAD_VERSION.deb /share/angharad/angharad_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  cp angharad_$ANGHARAD_VERSION.deb /opt/angharad_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  echo angharad_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb > /share/angharad/packages
  
  cp angharad_$ANGHARAD_VERSION.deb /share/angharad/angharad-dev_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  
  cd /opt
  
  tar cvz liborcania_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libyder_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libulfius_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libhoel_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          librhonabwy_${RHONABWY_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          libiddawc_${IDDAWC_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          angharad_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb \
          -f /share/angharad/angharad-full_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz
  echo angharad-full_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz >> /share/angharad/packages
  
  echo "$(date -R) angharad-full_${ANGHARAD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz build success" >> /share/summary.log
else
  echo "Files $ORCANIA_ARCHIVE or $YDER_ARCHIVE or $ULFIUS_ARCHIVE or $HOEL_ARCHIVE or $RHONABWY_ARCHIVE or $IDDAWC_ARCHIVE or $ANGHARAD_ARCHIVE not present" && false
fi
