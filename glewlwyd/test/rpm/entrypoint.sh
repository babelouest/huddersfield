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

  rpm --install /share/glewlwyd/liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/glewlwyd/libyder-dev_${YDER_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/glewlwyd/libhoel-dev_${HOEL_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/glewlwyd/libulfius-dev_${ULFIUS_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/glewlwyd/librhonabwy-dev_${RHONABWY_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm \
                /share/glewlwyd/libiddawc-dev_${IDDAWC_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm
  rpm -i --nodeps /share/glewlwyd/glewlwyd-dev_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  ldconfig
  
  mkdir -p /opt/glewlwyd/

  tar -xf $GLEWLWYD_ARCHIVE -C /opt/glewlwyd --strip 1

  cd /opt/glewlwyd/test

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/docs/database/init.sqlite3.sql

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/test/glewlwyd-test.sql

  glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-ci.conf &

  export G_PID=$!
  
  ./cert/create-cert.sh

  make test || (cat *.log && cat /tmp/glewlwyd.log && false)
  
  kill $G_PID

  make glewlwyd_scheme_certificate glewlwyd_oidc_client_certificate glewlwyd_prometheus
  
  glewlwyd --config-file=cert/glewlwyd-cert-ci.conf &

  export G_PID=$!
  
  sleep 2
  
  (./glewlwyd_scheme_certificate && ./glewlwyd_oidc_client_certificate) || (cat /tmp/glewlwyd-https.log && false)
  
  kill $G_PID

  glewlwyd --config-file=glewlwyd-profile-delete-disable.conf &

  export G_PID=$!

  sleep 2

  ./glewlwyd_profile_delete disable || (cat /tmp/glewlwyd-disable.log && false)

  kill $G_PID

  glewlwyd --config-file=glewlwyd-profile-delete-yes.conf &

  export G_PID=$!

  sleep 2

  ./glewlwyd_profile_delete delete || (cat /tmp/glewlwyd-delete.log && false)

  kill $G_PID

  glewlwyd --config-file=glewlwyd-prometheus.conf &
  
  sleep 2
  
  export G_PID=$!
  
  ./glewlwyd_prometheus || (cat /tmp/glewlwyd-prometheus.log && false)
  
  kill $G_PID
  
  echo "$(date -R) glewlwyd-dev_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm test complete success" >> /share/summary.log

else
  echo "File $GLEWLWYD_ARCHIVE not present" && false
fi
