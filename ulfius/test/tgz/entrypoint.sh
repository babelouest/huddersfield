#!/bin/bash

set -e

cd /opt/

./u_map
./core
#./framework # TODO re-enable it when you figure out how to make it work on docker
./websocket
