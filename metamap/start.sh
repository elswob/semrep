#!/bin/sh
/usr/sbin/nginx
cd /metamap/public_mm
./bin/skrmedpostctl start
./bin/wsdserverctl start
# allow time for the two servers to start
sleep 30
./bin/mmserver18
