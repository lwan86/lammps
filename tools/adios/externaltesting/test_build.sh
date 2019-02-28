#!/bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
REPOPATH=$(readlink -f "$SCRIPTPATH/../../..")
CURRDIR=$(readlink -f "$PWD")
echo "Build LAMMPS... "
echo "  repository:[$REPOPATH]"
echo "  build in  :[$CURRDIR/build]"

mkdir -p build
rm -rf build/*
cd build
$SCRIPTPATH/cmake_configure.sh $REPOPATH
EX=$?
if [ "$EX" -ne "0" ]; then
   echo "Build script failure at cmake configuration"
   exit $EX
fi
make -j 4
EX=$?
if [ "$EX" -ne "0" ]; then
   echo "Build script failure at make "
   exit $EX
fi

if [ ! -x lmp_adiosvm ]; then
   echo "Build script failure: the final executable is not found: build/lmp_adiosvm"
   exit 1
fi

echo "Built LAMMPS OK "
