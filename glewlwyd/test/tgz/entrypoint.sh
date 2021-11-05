#!/bin/bash

set -e

GLEWLWYD_ARCHIVE=/share/glewlwyd/glewlwyd.tar.gz

if [ -f $GLEWLWYD_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  GLEWLWYD_VERSION=$(cat /opt/GLEWLWYD_VERSION)
  
  tar xvf /share/glewlwyd/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/glewlwyd/libyder-dev_${YDER_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/glewlwyd/libhoel-dev_${HOEL_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/glewlwyd/libulfius-dev_${ULFIUS_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/glewlwyd/librhonabwy-dev_${RHONABWY_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/glewlwyd/libiddawc-dev_${IDDAWC_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  tar xvf /share/glewlwyd/glewlwyd-dev_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1

  mkdir /opt/glewlwyd/

  tar -xf $GLEWLWYD_ARCHIVE -C /opt/glewlwyd --strip 1

  mkdir /opt/glewlwyd/build

  cd /opt/glewlwyd/build

  cmake -DBUILD_GLEWLWYD_TESTING=on ..

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/docs/database/init.sqlite3.sql

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/test/glewlwyd-test.sql

  glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-ci.conf &

  export G_PID=$!
  
  ../test/cert/create-cert.sh

  ln -s ../test/cert/ .

  ln -s ../test/ .
  
  make test || (cat Testing/Temporary/LastTest.log && cat /tmp/glewlwyd.log && false)
  
  kill $G_PID

  make glewlwyd_scheme_certificate glewlwyd_oidc_client_certificate
  
  glewlwyd --config-file=cert/glewlwyd-cert-ci.conf &

  export G_PID=$!
  
  sleep 2
  
  (./glewlwyd_scheme_certificate && ./glewlwyd_oidc_client_certificate) || (cat /tmp/glewlwyd-https.log && false)
  
  kill $G_PID

  glewlwyd --config-file=test/glewlwyd-profile-delete-disable.conf &

  export G_PID=$!

  sleep 2

  ./glewlwyd_profile_delete disable || (cat /tmp/glewlwyd-disable.log && false)

  kill $G_PID

  glewlwyd --config-file=test/glewlwyd-profile-delete-yes.conf &

  export G_PID=$!

  sleep 2

  ./glewlwyd_profile_delete delete || (cat /tmp/glewlwyd-delete.log && false)

  kill $G_PID

  echo "$(date -R) glewlwyd-dev_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz test complete success" >> /share/summary.log

else
  echo "File $GLEWLWYD_ARCHIVE not present" && false
fi
