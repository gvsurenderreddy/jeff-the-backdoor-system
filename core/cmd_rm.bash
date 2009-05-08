#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 1

TARGET="${1}"
[[ "${TARGET}" =~ ^[a-zA-Z0-9_-]+$ ]] || die 'target name invalid!'

TARGET_BASH="${JBS_COMMANDS}/${TARGET}.bash"
TARGET_BASH_ASC="${JBS_COMMANDS}/${TARGET}.bash.asc"
TARGET_BASH_ACL="${JBS_COMMANDS}/${TARGET}.bash.acl"
TARGET_BASH_ACL_ASC="${JBS_COMMANDS}/${TARGET}.bash.acl.asc"

test -f "${TARGET_BASH}" || die 'target bash not found!'
test -f "${TARGET_BASH_ASC}" || die 'target bash signature not found!'
test -f "${TARGET_BASH_ACL}" || die 'target bash acl not found!'
test -f "${TARGET_BASH_ACL_ASC}" || die 'target bash acl signature not found!'

rm "${TARGET_BASH}" "${TARGET_BASH_ASC}" "${TARGET_BASH_ACL}" "${TARGET_BASH_ACL_ASC}"

exit 0
