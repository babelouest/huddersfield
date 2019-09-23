#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz

if [ -f $ORCANIA_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  
  tar xvf /share/orcania/liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz -C /usr/ --strip 1
  
  mkdir /opt/orcania

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1
  
  cd /opt/orcania/test
  
  make str_test split_test memory_test pointer_list_test
  
  ./str_test
  ./split_test
  ./memory_test
  ./pointer_list_test
  
  echo "$(date -R) liborcania-dev_${ORCANIA_VERSION}_`grep -e "^ID=" /etc/os-release |cut -c 4-`_`grep -e "^VERSION_ID=" /etc/os-release |cut -c 12-`_`uname -m`.tar.gz test complete success" >> /share/summary.log
else
  echo "File $ORCANIA_ARCHIVE not present" && false
fi
