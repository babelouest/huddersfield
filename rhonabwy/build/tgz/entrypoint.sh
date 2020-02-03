#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz
YDER_ARCHIVE=/share/yder/yder.tar.gz
ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz
RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz

if [ -f $ORCANIA_ARCHIVE ] && [ -f $YDER_ARCHIVE ] && [ -f $ULFIUS_ARCHIVE ] && [ -f $RHONABWY_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  
  mkdir /opt/orcania/

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  mkdir /opt/orcania/build

  cd /opt/orcania/build

  cmake -DCMAKE_INSTALL_LIBDIR=lib ..

  make package

  make install

  cp liborcania-dev_$ORCANIA_VERSION.tar.gz /opt/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  echo liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz > /share/ulfius/packages

  mkdir /opt/yder/

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1

  mkdir /opt/yder/build

  cd /opt/yder/build

  cmake -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_LIBDIR=lib -DWITH_JOURNALD=off ..

  make package

  make install

  cp libyder-dev_$YDER_VERSION.tar.gz /opt/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/ulfius/

  tar -zxf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  mkdir /opt/ulfius/build

  cd /opt/ulfius/build

  cmake -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_LIBDIR=lib ..

  make package

  make install

  cp libulfius-dev_$ULFIUS_VERSION.tar.gz /opt/libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/rhonabwy/

  tar -zxf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  mkdir /opt/rhonabwy/build

  cd /opt/rhonabwy/build

  cmake -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_LIBDIR=lib ..

  make package

  ls -l /opt/RHONABWY_VERSION
  cp librhonabwy-dev_$RHONABWY_VERSION.tar.gz /opt/librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  cp librhonabwy-dev_$RHONABWY_VERSION.tar.gz /share/rhonabwy/librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  echo librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz > /share/rhonabwy/packages

  cd /opt/

  tar cvz liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          -f /share/rhonabwy/rhonabwy-dev-full_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  echo rhonabwy-dev-full_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /share/rhonabwy/packages
  
  echo "$(date -R) rhonabwy-dev-full_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz build success" >> /share/summary.log
else
  echo "Files $ORCANIA_ARCHIVE or $YDER_ARCHIVE or $ULFIUS_ARCHIVE or $RHONABWY_ARCHIVE not present" && false
fi
