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

  ./cert/create-cert.sh

  make misc cookbook jwk_core jwk_import jwk_export jwks_core jws_core jws_hmac jws_rsa jws_ecdsa jws_rsapss jwe_core jwe_rsa jwe_dir jwe_aesgcm jwe_kw jwe_pbes2 jwe_rsa_oaep jwe_ecdh jwt_core jwt_sign jwt_encrypt jwt_nested
  
  ./misc
  ./cookbook
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
  ./jwe_aesgcm
  ./jwe_kw
  ./jwe_pbes2
  ./jwe_rsa_oaep
  ./jwe_ecdh
  ./jwt_core
  ./jwt_sign
  ./jwt_encrypt
  ./jwt_nested
  
  echo "$(date -R) rhonabwy-dev-full_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`lsb_release -c -s`_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $RHONABWY_ARCHIVE not present" && false
fi
