#!/bin/bash

BPLS=/opt/adios2/bin/bpls
TESTID=test01

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
TESTSRCPATH=$SCRIPTPATH/$TESTID.src
echo "Run $TESTID..."
echo "  $TESTID source:[$TESTSRCPATH]"

mkdir -p $TESTID.run
rm -rf $TESTID.run/*
cd $TESTID.run
cp $TESTSRCPATH/* .

mpirun -n 4 ../build/lmp_adiosvm -in in.test 2>&1 >log.run

EX=$?
if [ "$EX" -ne "0" ]; then
   echo "$TESTID failure at running the application"
   exit $EX
fi

./check_results.sh

EX=$?
if [ "$EX" -ne "0" ]; then
   echo "$TESTID failure at checking the results"
   exit $EX
fi

echo "$TESTID OK"

