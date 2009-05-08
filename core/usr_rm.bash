#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 1

TARGET="${1}"
[[ "${TARGET}" =~ ^[a-zA-Z0-9_-]+$ ]] || die 'target name invalid!'

TARGET_PUB="${JBS_USERS}/${TARGET}.pub"
TARGET_PUB_ASC="${JBS_USERS}/${TARGET}.pub.asc"

test -f "${TARGET_PUB}" || die 'target pub not found!'
test -f "${TARGET_PUB_ASC}" || die 'target pub signature not found!'

rm "${TARGET_PUB}" "${TARGET_PUB_ASC}"

"${JBS_USR_MK}"

exit 0
