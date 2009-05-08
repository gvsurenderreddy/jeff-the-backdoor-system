#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

export JBS_HOME
export JBS_USER
export JBS_CORE
export JBS_STORE
export JBS_TMP
export JBS_CMD_SHELL
export JBS_CMD_EXEC

test "${#}" -ge 1

TARGET="${1}"
TARGET_BASH="${JBS_COMMANDS}/${1}.bash"
TARGET_BASH_ACL="${JBS_COMMANDS}/${1}.bash.acl"

if test "${#}" -eq 1
then
	TARGET_ARGUMENTS=()
else
	TARGET_ARGUMENTS=( "${@:2}" )
fi

"${JBS_SIG_VFY}" "${TARGET_BASH}"
"${JBS_SIG_VFY}" "${TARGET_BASH_ACL}"
"${JBS_ACL_VFY}" "${TARGET_BASH}"

if test "${#TARGET_ARGUMENTS}" -eq 0
then
	exec bash "${TARGET_BASH}"
else
	exec bash "${TARGET_BASH}" "${TARGET_ARGUMENTS[@]}"
fi

exit 1
