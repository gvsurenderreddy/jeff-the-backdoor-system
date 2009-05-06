#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_HOME:-}" ; then . "${JBS_HOME}/core/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 1

TARGET_URL="${1}"
TARGET_BASH_URL="${TARGET_URL}.bash"
TARGET_BASH_ASC_URL="${TARGET_URL}.bash.asc"
TARGET_BASH_ACL_URL="${TARGET_URL}.bash.acl"
TARGET_BASH_ACL_ASC_URL="${TARGET_URL}.bash.acl.asc"

JBS_COMMANDS_NEW="${JBS_COMMANDS}/$( uuid )"
test ! -e "${JBS_COMMANDS_NEW}"
mkdir "${JBS_COMMANDS_NEW}"

pushd "${JBS_COMMANDS_NEW}" >/dev/null

curl -O -s "${TARGET_BASH_URL}" || die "target bash url {{${TARGET_BASH_URL}}} not found!"
curl -O -s "${TARGET_BASH_ASC_URL}" || die "target bash signature url {{${TARGET_BASH_ASC_URL}}} not found!"
curl -O -s "${TARGET_BASH_ACL_URL}" || die "target acl url {{${TARGET_BASH_ACL_URL}}} not found!"
curl -O -s "${TARGET_BASH_ACL_ASC_URL}" || die "target acl signature url {{${TARGET_BASH_ACL_ASC_URL}}} not found!"

"${JBS_VFY_SIG}" "${JBS_COMMANDS_NEW}"/*.bash
"${JBS_VFY_SIG}" "${JBS_COMMANDS_NEW}"/*.bash.acl
JBS_USER_OVERRIDE=true "${JBS_VFY_ACL}" "${JBS_COMMANDS_NEW}"/*.bash

mv "${JBS_COMMANDS_NEW}"/* "${JBS_COMMANDS}"

popd >/dev/null

rmdir "${JBS_COMMANDS_NEW}"

exit 0
