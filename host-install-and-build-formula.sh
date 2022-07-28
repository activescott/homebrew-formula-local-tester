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

[ -f "${THISDIR}/env.source.sh" ] && source "${THISDIR}/env.source.sh"

[ -z "${HOMEBREW_CORE_REPO}" ] && die "The HOMEBREW_CORE_REPO variable must be defined. See env.source.sh."
[ -d "${!HOMEBREW_CORE_REPO}" ] && die "The HOMEBREW_CORE_REPO variable must point to a valid directory but it does not (${!HOMEBREW_CORE_REPO}). See env.source.sh."

[ "$#" -eq 1 ] || die "the first argument must be a formula name"
FORMULA_NAME=$1
[ -f "$HOMEBREW_CORE_REPO/Formula/$FORMULA_NAME.rb" ] || die "ERROR: Formula doesn't exist! '$HOMEBREW_CORE_REPO/Formula/$FORMULA_NAME.rb'"

HOMEBREW_CORE_REPO_RUNNING=`brew --repository homebrew/core`
echo "Copying the formula ${FORMULA_NAME} into the actual/running homebrew directory..."
cp -v "$HOMEBREW_CORE_REPO/Formula/$FORMULA_NAME.rb" "${HOMEBREW_CORE_REPO_RUNNING}/Formula/"

# Below here does the install & build:
brew install --build-from-source "$FORMULA_NAME"