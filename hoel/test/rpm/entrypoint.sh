#!/bin/bash

set -e

HOEL_ARCHIVE=/share/hoel/hoel.tar.gz

if [ -f $HOEL_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  
  ls -l /share/hoel
  tar xvf /share/hoel/hoel-dev-full_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz
  yum install -y liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm
  yum install -y libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm
  yum install -y libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.rpm

  mkdir /opt/hoel/

  tar -zxvf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  cd /opt/hoel/test

  make core
  
  sqlite3 /tmp/test.db < test.sql

  ./core
else
  echo "File $HOEL_ARCHIVE not present" && false
fi
