#!/bin/bash

set -e

ORCANIA_ARCHIVE=/share/orcania/orcania.tar.gz

if [ -f $ORCANIA_ARCHIVE ]; then
  ORCANIA_VERSION=$(cat /opt/ORCANIA_VERSION)
  
  rpm --install /share/orcania/liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm

  mkdir /opt/orcania

  tar -zxvf $ORCANIA_ARCHIVE -C /opt/orcania --strip 1
  
  cd /opt/orcania/test
  
  make str_test split_test memory_test pointer_list_test
  
  ./str_test
  ./split_test
  ./memory_test
  ./pointer_list_test
  
  echo "$(date -R) liborcania-dev_${ORCANIA_VERSION}_$(lsb_release -si)_$(lsb_release -sd|tr -d \"|sed 's/ /_/g'|sed 's/[)(]//g')_$(uname -m).rpm test complete success" >> /share/summary.log
else
  echo "File $ORCANIA_ARCHIVE not present" && false
fi
