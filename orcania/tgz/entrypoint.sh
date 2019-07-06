#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz

if [ -f $ORCANIA_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  
  mkdir /opt/orcania/

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  mkdir /opt/orcania/build

  cd /opt/orcania/build

  cmake ..

  make

  make package
  echo pl $ORCANIA_VERSION op

  cp liborcania-dev_$ORCANIA_VERSION.tar.gz /share/orcania/liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz

  echo liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).tar.gz > /share/orcania/packages
else
  echo "File $ORCANIA_ARCHIVE not present" && false
fi
