#!/bin/bash

SRCDIR=$1
if [ ! -d "$SRCDIR" ]; then
   echo "Argument is not a valid directory for LAMMPS source: [$SRCDIR]" 
   exit 1
fi

cmake -D CMAKE_INSTALL_PREFIX=/opt/lammps \
      -D CMAKE_BUILD_TYPE=Debug \
      -D BUILD_MPI=yes \
      -D LAMMPS_MACHINE=adiosvm \
      -D BUILD_EXE=yes \
      -D BUILD_LIB=no \
      -D BUILD_SHARED_LIBS=no \
      -D BUILD_DOC=no \
      -D LAMMPS_SIZES=smallbig \
      -D PKG_USER-ADIOS=yes -DADIOS2_DIR=/opt/adios2 \
      $SRCDIR/cmake
