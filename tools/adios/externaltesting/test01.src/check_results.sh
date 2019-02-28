#!/bin/bash

BPLS=$ADIOS2_DIR/bin/bpls

# Check if output files exists
if [ ! -f balance_atom.bp ]; then
   echo "ERROR: balance_atom.bp was not produced"
   exit 1
fi

if [ ! -f balance_custom.bp ]; then
   echo "ERROR: balance_custom.bp was not produced"
   exit 1
fi

if [ ! -f balance.dump ]; then
   echo "ERROR: balance.dump was not produced"
   exit 1
fi

# Compare data from default I/O balance.dump and ADIOS output

BOUNDARY_DEFAULT=$(grep BOX balance.dump  | head -1 | cut -f 4,5,6 -d " ")
BOUNDARY_ADIOS=$($BPLS -l balance_custom.bp -a boundarystr | cut -d '"' -f 2)

if [ ! "$BOUNDARY_DEFAULT" = "$BOUNDARY_ADIOS" ]; then
    echo "Test01 failure: Attribute boundarystr in balance_custom.bp does not match the BOX BOUNDS in balance.dump"
    echo "balance.dump: [$BOUNDARY_DEFAULT]    balance_custom.bp/boundarystr: [$BOUNDARY_ADIOS]"
    exit 1
fi





