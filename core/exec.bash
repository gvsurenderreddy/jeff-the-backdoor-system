#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_HOME:-}" ; then . "${JBS_HOME}/core/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

export JBS_HOME
export JBS_USER
export JBS_SHELL
export JBS_EXEC

test "${#}" -ge 1

JBS_COMMAND="${1}"
JBS_COMMAND_BASH="${JBS_COMMANDS}/${1}.bash"
JBS_COMMAND_BASH_ACL="${JBS_COMMANDS}/${1}.bash.acl"

if test "${#}" -eq 1
then
	JBS_COMMAND_ARGUMENTS=()
else
	JBS_COMMAND_ARGUMENTS=( "${@:2}" )
fi

"${JBS_VFY_SIG}" "${JBS_COMMAND_BASH}"
"${JBS_VFY_SIG}" "${JBS_COMMAND_BASH_ACL}"
"${JBS_VFY_ACL}" "${JBS_COMMAND_BASH}"

if test "${#JBS_COMMAND_ARGUMENTS}" -eq 0
then
	exec bash "${JBS_COMMAND_BASH}"
else
	exec bash "${JBS_COMMAND_BASH}" "${JBS_COMMAND_ARGUMENTS[@]}"
fi

exit 1
