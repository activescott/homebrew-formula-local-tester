#!/usr/bin/env sh
THISDIR=$(cd $(dirname "$0"); pwd) #this script's directory
THISSCRIPT=$(basename $0)

help () {
    echo ""
}
die () {
    echo >&2 "$@"
    help
    exit 1
}

[ -f "${THISDIR}/env.source.sh" ] && source "${THISDIR}/env.source.sh"

[ -z "${HOMEBREW_CORE_REPO}" ] && die "The HOMEBREW_CORE_REPO variable must be defined. See env.source.sh."
[ -d "${!HOMEBREW_CORE_REPO}" ] && die "The HOMEBREW_CORE_REPO variable must point to a valid directory but it does not (${!HOMEBREW_CORE_REPO}). See env.source.sh."
echo "Using homebrew core repo at $HOMEBREW_CORE_REPO"

[ "$#" -eq 1 ] || die "the first argument must be a formula name"
FORMULA_NAME=$1
echo "Using FORMULA_NAME '${FORMULA_NAME}'..."

[ -f "$HOMEBREW_CORE_REPO/Formula/$FORMULA_NAME.rb" ] || die "ERROR: Formula doesn't exist! '$HOMEBREW_CORE_REPO/Formula/$FORMULA_NAME.rb'"

# copy the formula to staging since docker doesn't like to follow symlinks
rm -fv "$THISDIR/staging/$FORMULA_NAME.rb"
cp -v "$HOMEBREW_CORE_REPO/Formula/$FORMULA_NAME.rb" $THISDIR/staging/

# build the docker file:
DOCKERFILE=$THISDIR/homebrew-test-linux.Dockerfile
TAG=`basename -s .Dockerfile $DOCKERFILE`

echo "using tag $TAG"

TSTAMP=$(date +"%Y%m%d%H%M%s")

PROGRESS_NO_TRUNC=1 docker build \
    --progress plain \
    --tag $TAG \
    -f $DOCKERFILE \
    --build-arg FORMULA_NAME=$FORMULA_NAME \
    . 2>&1 | tee "$THISDIR/$THISSCRIPT.$TSTAMP.log"
