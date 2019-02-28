#!/bin/bash

if [ ! -d "$ADIOS2_DIR" ]; then
    echo "ADIOS2_DIR environment variable must be set"
    exit 1
fi

if [ ! -x "$ADIOS2_DIR/bin/bpls" ]; then
    echo "ADIOS2_DIR environment variable is set but <ADIOS2_DIR>/bin/bpls is not found"
    exit 1
fi

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
echo scripts path:[$SCRIPTPATH]

$SCRIPTPATH/test_build.sh
EX=$?
if [ "$EX" -ne "0" ]; then
   echo "test.sh: Build failed"
   exit $EX
fi

$SCRIPTPATH/test_run_01.sh
EX=$?
if [ "$EX" -ne "0" ]; then
   echo "test.sh: Test 01 failed"
   exit $EX
fi



