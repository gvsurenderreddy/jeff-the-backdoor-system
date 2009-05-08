#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 2

TARGET="${1}"
[[ "${TARGET}" =~ ^[a-zA-Z0-9_-]+$ ]] || die 'target name invalid!'

TARGET_URL="${2}"

TARGET_PUB_URL="${TARGET_URL}/${TARGET}.pub"
TARGET_PUB_ASC_URL="${TARGET_URL}/${TARGET}.pub.asc"

JBS_USERS_NEW="${JBS_TMP}/$( uuid )"
test ! -e "${JBS_USERS_NEW}"
mkdir "${JBS_USERS_NEW}"

pushd "${JBS_USERS_NEW}" >/dev/null

curl -O -s "${TARGET_PUB_URL}" || die "target pub url {{${TARGET_PUB_URL}}} not found!"
curl -O -s "${TARGET_PUB_ASC_URL}" || die "target pub signature url {{${TARGET_PUB_ASC_URL}}} not found!"

"${JBS_SIG_VFY}" "${JBS_USERS_NEW}/${TARGET}.pub"

mv "${JBS_USERS_NEW}/${TARGET}.pub" "${JBS_USERS}"
mv "${JBS_USERS_NEW}/${TARGET}.pub.asc" "${JBS_USERS}"

popd >/dev/null

rmdir "${JBS_USERS_NEW}"

"${JBS_USR_MK}"

exit 0
