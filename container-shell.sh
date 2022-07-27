#!/usr/bin/env sh
THISDIR=$(cd $(dirname "$0"); pwd) #this script's directory
THISSCRIPT=$(basename $0)

die () {
    echo >&2 "$@"
    help
    exit 1
}

DOCKERFILE=$THISDIR/homebrew-test-linux.Dockerfile
TAG=`basename -s .Dockerfile $DOCKERFILE`

docker run \
  --mount source=homebrew-core,target=/mnt/homebrew \
  -it \
  $TAG \
  sh
