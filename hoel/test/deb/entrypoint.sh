#!/bin/bash

set -e

cd /opt/

sqlite3 /tmp/test.db < test.sql
./core
