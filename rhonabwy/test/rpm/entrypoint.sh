#!/bin/bash

set -e

RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz

if [ -f $RHONABWY_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  
  tar xvf /share/rhonabwy/rhonabwy-dev-full_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.tar.gz
  rpm --install liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm
  rpm --install librhonabwy-dev_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm

  mkdir /opt/rhonabwy/

  tar -zxf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  cd /opt/rhonabwy/test

  make misc jwk_core jwk_export jwk_import jwks_core jws_core jws_hmac jws_ecdsa jws_rsa jws_rsapss jwe_core jwe_rsa jwe_dir
  
  ./misc
  ./jwk_core
  ./jwk_export
  ./jwk_import
  ./jwks_core
  ./jws_core
  ./jws_hmac
  ./jws_ecdsa
  ./jws_rsa
  ./jws_rsapss
  ./jwe_core
  ./jwe_rsa
  ./jwe_dir
  
  echo "$(date -R) rhonabwy-dev_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_`uname -m`.rpm test complete success" >> /share/summary.log
else
  echo "File $RHONABWY_ARCHIVE not present" && false
fi
