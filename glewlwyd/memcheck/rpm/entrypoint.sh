#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz
YDER_ARCHIVE=/share/yder/yder.tar.gz
ULFIUS_ARCHIVE=/share/ulfius/ulfius.tar.gz
HOEL_ARCHIVE=/share/hoel/hoel.tar.gz
RHONABWY_ARCHIVE=/share/rhonabwy/rhonabwy.tar.gz
IDDAWC_ARCHIVE=/share/iddawc/iddawc.tar.gz
GLEWLWYD_ARCHIVE=/share/glewlwyd/glewlwyd.tar.gz

if [ -f $GLEWLWYD_ARCHIVE ]; then
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  GLEWLWYD_VERSION=$(cat /opt/GLEWLWYD_VERSION)

  export PKG_CONFIG_PATH=/usr/lib/pkgconfig
  
  # Orcania
  mkdir /opt/orcania/

  tar -xf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  cd /opt/orcania/src

  make debug install DESTDIR=/usr

  # Yder
  mkdir /opt/yder/

  tar -xf $YDER_ARCHIVE -C /opt/yder --strip 1

  cd /opt/yder/src

  make debug install DESTDIR=/usr

  # Ulfius
  mkdir /opt/ulfius/

  tar -xf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  cd /opt/ulfius/src

  make debug install DESTDIR=/usr

  # Hoel
  mkdir /opt/hoel/

  tar -xf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  cd /opt/hoel/src

  make debug install DESTDIR=/usr

  # Rhonabwy
  mkdir /opt/rhonabwy/

  tar -xf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  cd /opt/rhonabwy/src

  make debug install DESTDIR=/usr

  # Iddawc
  mkdir /opt/iddawc/

  tar -xf $IDDAWC_ARCHIVE -C /opt/iddawc --strip 1

  cd /opt/iddawc/src

  make debug install DESTDIR=/usr

  # Glewlwyd
  mkdir /opt/glewlwyd/

  tar -xf $GLEWLWYD_ARCHIVE -C /opt/glewlwyd --strip 1

  cd /opt/glewlwyd/src
  
  make debug install DESTDIR=/usr
  
  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/docs/database/init.sqlite3.sql

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/test/glewlwyd-test.sql

  cd ../test/
  
  ./cert/create-cert.sh
  
  touch /tmp/glewlwyd.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-ci.conf 2>/share/glewlwyd/valgrind_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).txt &
  
  export G_PID=$!

  tail -f /tmp/glewlwyd.log | sed '/Glewlwyd\ started/ q' > /dev/null
  
  make test || (cat /tmp/glewlwyd.log && false)
  
  kill -TERM $G_PID

  tail -f /tmp/glewlwyd.log | sed '/Glewlwyd\ stopped/ q' > /dev/null
  
  touch /tmp/glewlwyd-https.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/cert/glewlwyd-cert-ci.conf 2>/share/glewlwyd/valgrind_https_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).txt &
  
  export G_PID=$!

  tail -f /tmp/glewlwyd-https.log | sed '/Glewlwyd\ started/ q' > /dev/null
  
  make test_glewlwyd_scheme_certificate || (cat /tmp/glewlwyd-https.log && cat glewlwyd_scheme_certificate.log && false)
  
  make test_glewlwyd_oidc_client_certificate || (cat /tmp/glewlwyd-https.log && cat glewlwyd_oidc_client_certificate.log && false)
  
  kill -TERM $G_PID

  tail -f /tmp/glewlwyd-https.log | sed '/Glewlwyd\ stopped/ q' > /dev/null
  
  touch /tmp/glewlwyd-disable.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-profile-delete-disable.conf 2>/share/glewlwyd/valgrind_profile_delete_disable_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).txt &
  
  export G_PID=$!

  tail -f /tmp/glewlwyd-disable.log | sed '/Glewlwyd\ started/ q' > /dev/null
  
  ./glewlwyd_profile_delete disable || (cat /tmp/glewlwyd-disable.log && false)

  kill -TERM $G_PID

  tail -f /tmp/glewlwyd-disable.log | sed '/Glewlwyd\ stopped/ q' > /dev/null
  
  touch /tmp/glewlwyd-delete.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-profile-delete-yes.conf 2>/share/glewlwyd/valgrind_profile_delete_yes_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).txt &
  
  export G_PID=$!

  tail -f /tmp/glewlwyd-delete.log | sed '/Glewlwyd\ started/ q' > /dev/null
  
  ./glewlwyd_profile_delete delete || (cat /tmp/glewlwyd-delete.log && false)

  kill -TERM $G_PID

  tail -f /tmp/glewlwyd-delete.log | sed '/Glewlwyd\ stopped/ q' > /dev/null
  
  echo "$(date -R) glewlwyd-dev_${GLEWLWYD_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm memcheck complete success" >> /share/summary.log

else
  echo "File $GLEWLWYD_ARCHIVE not present" && false
fi
