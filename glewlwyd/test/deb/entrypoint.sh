#!/bin/bash

set -e

GLEWLWYD_ARCHIVE=/share/glewlwyd/glewlwyd.tar.gz

if [ -f $GLEWLWYD_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  GLEWLWYD_VERSION=$(cat /opt/GLEWLWYD_VERSION)
  
  dpkg -i /share/glewlwyd/liborcania-dev_${ORCANIA_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i /share/glewlwyd/libyder-dev_${YDER_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i /share/glewlwyd/libhoel-dev_${HOEL_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i /share/glewlwyd/libulfius-dev_${ULFIUS_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb
  dpkg -i /share/glewlwyd/glewlwyd-dev_${GLEWLWYD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb

  mkdir -p /opt/glewlwyd/

  tar -xf $GLEWLWYD_ARCHIVE -C /opt/glewlwyd --strip 1

  cd /opt/glewlwyd/test

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/docs/database/init.sqlite3.sql

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/test/glewlwyd-test.sql

  glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-ci.conf &

  export G_PID=$!
  
  make test
  
  kill $G_PID

  make glewlwyd_scheme_certificate
  
  ../test/cert/create-cert.sh
  
  glewlwyd --config-file=cert/glewlwyd-cert-ci.conf &

  export G_PID=$!
  
  sleep 2
  
  ./glewlwyd_scheme_certificate || (cat /tmp/glewlwyd-https.log && false)
  
  kill $G_PID
  
  echo "$(date -R) glewlwyd-dev_${GLEWLWYD_VERSION}_$(grep -e "^ID=" /etc/os-release |cut -c 4-)_$(lsb_release -c -s)_$(uname -m).deb test complete success" >> /share/summary.log

else
  echo "File $GLEWLWYD_ARCHIVE not present" && false
fi
