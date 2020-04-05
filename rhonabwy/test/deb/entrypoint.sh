#!/bin/bash

set -e

RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz

if [ -f $RHONABWY_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  
  tar xvf /share/rhonabwy/rhonabwy-dev-full_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz
  dpkg -i liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i libulfius-dev_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i librhonabwy-dev_${RHONABWY_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

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
  
  echo "$(date -R) rhonabwy-dev-full_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $RHONABWY_ARCHIVE not present" && false
fi
