#!/bin/bash

source ./pantheon/env.sh > /dev/null 2>&1

echo "----------------------------------------------------------------------"
echo "PTN: validating" 

OUTPUT=$PANTHEON_RUN_DIR/cinema_databases/$PANTHEON_CDB
GOLD=validate/data/cloverleaf3d_001.cdb

echo "    $OUTPUT"

dirs="0.0"
img="-180.0_0.0_pantheon.cdb.png"

PASS=true
if [ -d $OUTPUT ]; then
    for val in $dirs; do
        if [ ! -f $OUTPUT/$val/$img ]; then
            echo "FILE does not exist:"
            echo "    $OUTPUT/$val/$img"
            PASS=false
        fi
    done
else
    echo "Cinema Database: $OUTPUT does not exist"
    PASS=false
fi

if $PASS; then
    echo "PTN: PASS"
    echo "----------------------------------------------------------------------"
else
    echo "PTN: FAIL"
    echo "----------------------------------------------------------------------"
    exit 1
fi

