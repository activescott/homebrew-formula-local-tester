#!/usr/bin/env sh
THISDIR=$(cd $(dirname "$0"); pwd) #this script's directory
THISSCRIPT=$(basename $0)

help () { 
  echo " "
}

die () {
    echo >&2 "$@"
    help
    exit 1
}

FORMULA_NAME=onlykey-agent
./test-1-local.sh $FORMULA_NAME && ./test-2-build-bottle-in-container-linux.sh $FORMULA_NAME