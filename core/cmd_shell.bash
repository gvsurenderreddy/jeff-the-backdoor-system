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

if test "${#}" -eq 0
then
	exec python "${JBS_CORE}/cmd_shell.py"
elif test "${#}" -eq 2 && test "${1}" == '-c'
then
	exec python "${JBS_CORE}/cmd_shell.py" "${2}"
fi

exit 1
