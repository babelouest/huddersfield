#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz
YDER_ARCHIVE=/share/yder/yder.tar.gz
ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz
HOEL_ARCHIVE=/share/hoel/hoel.tar.gz
RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz
IDDAWC_ARCHIVE=/share/iddawc/iddawc.tar.gz
HUTCH_ARCHIVE=/share/hutch/hutch.tar.gz

if [ -f $ORCANIA_ARCHIVE ] && [ -f $YDER_ARCHIVE ] && [ -f $ULFIUS_ARCHIVE ] && [ -f $HOEL_ARCHIVE ] && [ -f $RHONABWY_ARCHIVE ] && [ -f $IDDAWC_ARCHIVE ] && [ -f $HUTCH_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  HUTCH_VERSION=$(cat /opt/HUTCH_VERSION)
  
  mkdir /opt/orcania/

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  mkdir /opt/orcania/build

  cd /opt/orcania/build

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..

  make install

  make package

  cp liborcania-dev_$ORCANIA_VERSION.tar.gz /share/hutch/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DINSTALL_HEADER=off ..

  make package

  cp liborcania_$ORCANIA_VERSION.tar.gz /opt/liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/yder/

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1

  mkdir /opt/yder/build

  cd /opt/yder/build

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DWITH_JOURNALD=off ..

  make install

  make package

  cp libyder-dev_$YDER_VERSION.tar.gz /share/hutch/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DWITH_JOURNALD=off -DINSTALL_HEADER=off ..

  make package

  cp libyder_$YDER_VERSION.tar.gz /opt/libyder_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  mkdir /opt/ulfius/build

  cd /opt/ulfius/build

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..

  make install

  make package

  cp libulfius-dev_$ULFIUS_VERSION.tar.gz /share/hutch/libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DINSTALL_HEADER=off ..

  make package

  cp libulfius_$ULFIUS_VERSION.tar.gz /opt/libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/hoel/

  tar -zxvf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  mkdir /opt/hoel/build

  cd /opt/hoel/build

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..

  make install

  make package

  cp libhoel-dev_$HOEL_VERSION.tar.gz /share/hutch/libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DINSTALL_HEADER=off ..

  make package

  cp libhoel_$HOEL_VERSION.tar.gz /opt/libhoel_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/rhonabwy/

  tar -zxvf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  mkdir /opt/rhonabwy/build

  cd /opt/rhonabwy/build

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..

  make install

  make package

  cp librhonabwy-dev_$RHONABWY_VERSION.tar.gz /share/hutch/librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DINSTALL_HEADER=off ..

  make package

  cp librhonabwy_$RHONABWY_VERSION.tar.gz /opt/librhonabwy_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/iddawc/

  tar -zxvf $IDDAWC_ARCHIVE -C /opt/iddawc --strip 1

  mkdir /opt/iddawc/build

  cd /opt/iddawc/build

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..

  make install

  make package

  cp libiddawc-dev_$IDDAWC_VERSION.tar.gz /share/hutch/libiddawc-dev_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DINSTALL_HEADER=off ..

  make package

  cp libiddawc_$IDDAWC_VERSION.tar.gz /opt/libiddawc_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz

  mkdir /opt/hutch/

  tar -zxvf $HUTCH_ARCHIVE -C /opt/hutch --strip 1

  mkdir /opt/hutch/build
  
  cd /opt/hutch/build
  
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..
  
  make package 
  
  cp hutch_$HUTCH_VERSION.tar.gz /share/hutch/hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  cp hutch_$HUTCH_VERSION.tar.gz /opt/hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  echo hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz > /share/hutch/packages
  
  rm -rf *
  
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib ..
  
  make package 
  
  cp hutch_$HUTCH_VERSION.tar.gz /share/hutch/hutch-dev_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  
  cd /opt
  
  tar cvz liborcania_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          libyder_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          libulfius_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          libhoel_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          librhonabwy_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          libiddawc_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          hutch_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz \
          -f /share/hutch/hutch-full_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz
  echo hutch-full_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz >> /share/hutch/packages
  
  echo "$(date -R) hutch-full_${HUTCH_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz build success" >> /share/summary.log
else
  echo "Files $ORCANIA_ARCHIVE or $YDER_ARCHIVE or $ULFIUS_ARCHIVE or $HOEL_ARCHIVE or $HUTCH_ARCHIVE not present" && false
fi
