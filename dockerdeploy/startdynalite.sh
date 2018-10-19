#!/bin/sh

if [ -z ${PERSISTENT_DIR+x} ]; then
    PERSISTENT_DIR="/data/dynalite"
fi
if [ -z ${PORT+x} ]; then
    PORT=14567
fi
echo $PERSISTENT_DIR
echo $PORT
/usr/local/bin/dynalite --port ${PORT} --path ${PERSISTENT_DIR} --createTableMs 0 --deleteTableMs 0 --updateTableMs 0 --httpKeepAliveTimeout=50000
