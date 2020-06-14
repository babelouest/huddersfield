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
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  YDER_VERSION=$(cat /opt/YDER_VERSION)
  HOEL_VERSION=$(cat /opt/HOEL_VERSION)
  ULFIUS_VERSION=$(cat /opt/ULFIUS_VERSION)
  RHONABWY_VERSION=$(cat /opt/RHONABWY_VERSION)
  IDDAWC_VERSION=$(cat /opt/IDDAWC_VERSION)
  GLEWLWYD_VERSION=$(cat /opt/GLEWLWYD_VERSION)
  
  # Orcania
  mkdir /opt/orcania/

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1

  cd /opt/orcania/src

  make debug install DESTDIR=/usr
  ln -s /usr/lib/liborcania.so.${ORCANIA_VERSION} /usr/lib/liborcania.so

  # Yder
  mkdir /opt/yder/

  tar -zxvf $YDER_ARCHIVE -C /opt/yder --strip 1

  cd /opt/yder/src

  make debug install DESTDIR=/usr Y_DISABLE_JOURNALD=1
  ln -s /usr/lib/libyder.so.${YDER_VERSION} /usr/lib/libyder.so

  # Ulfius
  mkdir /opt/ulfius/

  tar -zxvf $ULFIUS_ARCHIVE -C /opt/ulfius --strip 1

  cd /opt/ulfius/src

  make debug install DESTDIR=/usr
  ln -s /usr/lib/libulfius.so.${ULFIUS_VERSION} /usr/lib/libulfius.so

  # Hoel
  mkdir /opt/hoel/

  tar -zxvf $HOEL_ARCHIVE -C /opt/hoel --strip 1

  cd /opt/hoel/src

  make debug install DESTDIR=/usr
  ln -s /usr/lib/libhoel.so.${HOEL_VERSION} /usr/lib/libhoel.so

  # Rhonabwy
  mkdir /opt/rhonabwy/

  tar -zxvf $RHONABWY_ARCHIVE -C /opt/rhonabwy --strip 1

  cd /opt/rhonabwy/src

  make debug install DESTDIR=/usr
  ln -s /usr/lib/librhonabwy.so.${RHONABWY_VERSION} /usr/lib/librhonabwy.so

  # Iddawc
  mkdir /opt/iddawc/

  tar -zxvf $IDDAWC_ARCHIVE -C /opt/iddawc --strip 1

  cd /opt/iddawc/src

  make debug install DESTDIR=/usr
  ln -s /usr/lib/libiddawc.so.${IDDAWC_VERSION} /usr/lib/libiddawc.so

  # Glewlwyd
  mkdir /opt/glewlwyd/

  tar -zxvf $GLEWLWYD_ARCHIVE -C /opt/glewlwyd --strip 1

  cd /opt/glewlwyd/src
  
  make debug install DESTDIR=/usr
  
  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/docs/database/init.sqlite3.sql

  sqlite3 /tmp/glewlwyd.db < /opt/glewlwyd/test/glewlwyd-test.sql

  cd ../test/
  
  ./cert/create-cert.sh

  touch /tmp/glewlwyd.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-ci.conf 2>/share/glewlwyd/valgrind_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.txt &
  
  export G_PID=$!

  sleep 4
  
  make test || (cat /tmp/glewlwyd.log && false)
  
  kill -TERM $G_PID

  sleep 4
  
  touch /tmp/glewlwyd-https.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/cert/glewlwyd-cert-ci.conf 2>/share/glewlwyd/valgrind_https_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.txt &
  
  export G_PID=$!

  sleep 4
  
  make test_glewlwyd_scheme_certificate || (cat /tmp/glewlwyd-https.log && cat glewlwyd_scheme_certificate.log && false)
  
  make test_glewlwyd_oidc_client_certificate || (cat /tmp/glewlwyd-https.log && cat glewlwyd_oidc_client_certificate.log && false)
  
  kill -TERM $G_PID

  sleep 4
  
  touch /tmp/glewlwyd-disable.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-profile-delete-disable.conf 2>/share/glewlwyd/valgrind_profile_delete_disable_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.txt &
  
  export G_PID=$!

  sleep 4
  
  ./glewlwyd_profile_delete disable || (cat /tmp/glewlwyd-disable.log && false)

  kill -TERM $G_PID

  sleep 4
  
  touch /tmp/glewlwyd-delete.log
  
  valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes glewlwyd --config-file=/opt/glewlwyd/test/glewlwyd-profile-delete-yes.conf 2>/share/glewlwyd/valgrind_profile_delete_yes_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.txt &
  
  export G_PID=$!

  sleep 4
  
  ./glewlwyd_profile_delete delete || (cat /tmp/glewlwyd-delete.log && false)

  kill -TERM $G_PID

  sleep 4
  
  echo "$(date -R) glewlwyd-dev_${GLEWLWYD_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz memcheck complete success" >> /share/summary.log

else
  echo "File $GLEWLWYD_ARCHIVE not present" && false
fi
