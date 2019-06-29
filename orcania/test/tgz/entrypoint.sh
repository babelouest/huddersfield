#!/bin/bash

set -e

cd /opt/

LD_LIBRARY_PATH=/usr/lib64 ./str_test
LD_LIBRARY_PATH=/usr/lib64 ./split_test
LD_LIBRARY_PATH=/usr/lib64 ./memory_test
LD_LIBRARY_PATH=/usr/lib64 ./pointer_list_test
