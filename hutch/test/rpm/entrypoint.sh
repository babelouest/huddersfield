#!/bin/bash

set -e

HUTCH_ARCHIVE=/share/hutch/hutch.tar.gz

if [ -f $HUTCH_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  HUTCH_VERSION=$(cat /opt/HUTCH_VERSION)

  rpm --install /share/hutch/liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/hutch/libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/hutch/libhoel-dev_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/hutch/libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/hutch/librhonabwy-dev_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/hutch/libiddawc-dev_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  rpm -i --nodeps /share/hutch/hutch-dev_${HUTCH_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  ldconfig
  
  mkdir -p /opt/hutch/

  tar -xf $HUTCH_ARCHIVE -C /opt/hutch --strip 1
  
  mkdir /opt/hutch/build

  cd /opt/hutch/build

  rnbyc -j -g EC256 -a ES256 -k ES256 -o sign.jwks -p /dev/null
  
  rnbyc -j -g EC256 -a ES256 -o private-test.jwks -p public-test.jwks

  cmake -DBUILD_TESTING=on ..

  sqlite3 /tmp/hutch.db < /opt/hutch/docs/hutch.sqlite3.sql

  hutch --config-file=/opt/hutch/test/hutch-ci.conf &
  
  export G_PID=$!

  make test || (cat Testing/Temporary/LastTest.log && cat /tmp/hutch.log && false)
  
  kill -TERM $G_PID

  echo "$(date -R) hutch-dev_${HUTCH_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm test complete success" >> /share/summary.log

else
  echo "File $HUTCH_ARCHIVE not present" && false
fi
