#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_HOME:-}" ; then . "${JBS_HOME}/core/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

export JBS_HOME
export JBS_USER
export JBS_SHELL
export JBS_EXEC

if test "${#}" -eq 0
then
	exec python "${JBS_CORE}/shell.py"
elif test "${#}" -eq 2 && test "${1}" == '-c'
then
	exec python "${JBS_CORE}/shell.py" "${2}"
fi

exit 1
