#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz
YDER_ARCHIVE=/share/yder/yder.tar.gz
ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz
HOEL_ARCHIVE=/share/hoel/hoel.tar.gz
RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz
IDDAWC_ARCHIVE=/share/iddawc/iddawc.tar.gz
GLEWLWYD_ARCHIVE=/share/glewlwyd/glewlwyd.tar.gz

if [ -f $ORCANIA_ARCHIVE ] && [ -f $YDER_ARCHIVE ] && [ -f $ULFIUS_ARCHIVE ] && [ -f $HOEL_ARCHIVE ] && [ -f $RHONABWY_ARCHIVE ] && [ -f $IDDAWC_ARCHIVE ] && [ -f $GLEWLWYD_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  GLEWLWYD_VERSION=$(cat /opt/GLEWLWYD_VERSION)
  
  mkdir /opt/orcania/

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  mkdir /opt/orcania/build

  cd /opt/orcania/build

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on ..

  make install

  make package

  cp liborcania-dev_$ORCANIA_VERSION.rpm /share/glewlwyd/liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on -DINSTALL_HEADER=off ..

  make package

  cp liborcania_$ORCANIA_VERSION.rpm /opt/liborcania_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/yder/

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1

  mkdir /opt/yder/build

  cd /opt/yder/build

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on ..

  make install

  make package

  cp libyder-dev_$YDER_VERSION.rpm /share/glewlwyd/libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on -DINSTALL_HEADER=off ..

  make package

  cp libyder_$YDER_VERSION.rpm /opt/libyder_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  mkdir /opt/ulfius/build

  cd /opt/ulfius/build

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on ..

  make install

  make package

  cp libulfius-dev_$ULFIUS_VERSION.rpm /share/glewlwyd/libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on -DINSTALL_HEADER=off ..

  make package

  cp libulfius_$ULFIUS_VERSION.rpm /opt/libulfius_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/hoel/

  tar -zxvf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  mkdir /opt/hoel/build

  cd /opt/hoel/build

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on ..

  make install

  make package

  cp libhoel-dev_$HOEL_VERSION.rpm /share/glewlwyd/libhoel-dev_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on -DINSTALL_HEADER=off ..

  make package

  cp libhoel_$HOEL_VERSION.rpm /opt/libhoel_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  # Rhonabwy
  mkdir /opt/rhonabwy/

  tar -zxvf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  mkdir /opt/rhonabwy/build

  cd /opt/rhonabwy/build

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on ..

  make install

  make package

  cp librhonabwy-dev_$RHONABWY_VERSION.rpm /share/glewlwyd/librhonabwy-dev_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_RPM=on -DINSTALL_HEADER=off ..

  make package

  cp librhonabwy_$RHONABWY_VERSION.rpm /opt/librhonabwy_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  # Iddawc
  mkdir /opt/iddawc/

  tar -zxvf $IDDAWC_ARCHIVE -C /opt/iddawc --strip 1

  mkdir /opt/iddawc/build

  cd /opt/iddawc/build

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_IDWCC=OFF -DBUILD_RPM=on ..

  make install

  make package

  cp libiddawc-dev_$IDDAWC_VERSION.rpm /share/glewlwyd/libiddawc-dev_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  rm -rf *

  cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_IDWCC=OFF -DBUILD_RPM=on -DINSTALL_HEADER=off ..

  make package

  cp libiddawc_$IDDAWC_VERSION.rpm /opt/libiddawc_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/glewlwyd/

  tar -zxvf $GLEWLWYD_ARCHIVE -C /opt/glewlwyd --strip 1

  mkdir /opt/glewlwyd/build
  
  cd /opt/glewlwyd/build
  
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_RPM=on ..
  
  make package 
  
  cp glewlwyd_$GLEWLWYD_VERSION.rpm /share/glewlwyd/glewlwyd_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  cp glewlwyd_$GLEWLWYD_VERSION.rpm /opt/glewlwyd_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  echo glewlwyd_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm > /share/glewlwyd/packages
  
  rm -rf *
  
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_RPM=on -DWITH_MOCK=on ..
  
  make package 
  
  cp glewlwyd_$GLEWLWYD_VERSION.rpm /share/glewlwyd/glewlwyd-dev_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  
  cd /opt
  
  tar cvz liborcania_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          libyder_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          libulfius_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          libhoel_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          librhonabwy_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          libiddawc_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          glewlwyd_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
          -f /share/glewlwyd/glewlwyd-full_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).tar.gz
  echo glewlwyd-full_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).tar.gz >> /share/glewlwyd/packages
  
  echo "$(date -R) glewlwyd-full_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).tar.gz build success" >> /share/summary.log
else
  echo "Files $ORCANIA_ARCHIVE or $YDER_ARCHIVE or $ULFIUS_ARCHIVE or $HOEL_ARCHIVE or $RHONABWY_ARCHIVE or $IDDAWC_ARCHIVE or $GLEWLWYD_ARCHIVE not present" && false
fi
