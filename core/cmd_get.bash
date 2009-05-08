#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 2

TARGET="${1}"
[[ "${TARGET}" =~ ^[a-zA-Z0-9_-]+$ ]] || die 'target name invalid!'

TARGET_URL="${2}"

TARGET_BASH_URL="${TARGET_URL}/${TARGET}.bash"
TARGET_BASH_ASC_URL="${TARGET_URL}/${TARGET}.bash.asc"
TARGET_BASH_ACL_URL="${TARGET_URL}/${TARGET}.bash.acl"
TARGET_BASH_ACL_ASC_URL="${TARGET_URL}/${TARGET}.bash.acl.asc"

JBS_COMMANDS_NEW="${JBS_TMP}/$( uuid )"
test ! -e "${JBS_COMMANDS_NEW}"
mkdir "${JBS_COMMANDS_NEW}"

pushd "${JBS_COMMANDS_NEW}" >/dev/null

curl -O -s "${TARGET_BASH_URL}" || die "target bash url {{${TARGET_BASH_URL}}} not found!"
curl -O -s "${TARGET_BASH_ASC_URL}" || die "target bash signature url {{${TARGET_BASH_ASC_URL}}} not found!"
curl -O -s "${TARGET_BASH_ACL_URL}" || die "target acl url {{${TARGET_BASH_ACL_URL}}} not found!"
curl -O -s "${TARGET_BASH_ACL_ASC_URL}" || die "target acl signature url {{${TARGET_BASH_ACL_ASC_URL}}} not found!"

"${JBS_SIG_VFY}" "${JBS_COMMANDS_NEW}/${TARGET}.bash"
"${JBS_SIG_VFY}" "${JBS_COMMANDS_NEW}/${TARGET}.bash.acl"
JBS_USER_OVERRIDE=true "${JBS_ACL_VFY}" "${JBS_COMMANDS_NEW}/${TARGET}.bash"

mv "${JBS_COMMANDS_NEW}/${TARGET}.bash" "${JBS_COMMANDS}"
mv "${JBS_COMMANDS_NEW}/${TARGET}.bash.asc" "${JBS_COMMANDS}"
mv "${JBS_COMMANDS_NEW}/${TARGET}.bash.acl" "${JBS_COMMANDS}"
mv "${JBS_COMMANDS_NEW}/${TARGET}.bash.acl.asc" "${JBS_COMMANDS}"

popd >/dev/null

rmdir "${JBS_COMMANDS_NEW}"

exit 0
