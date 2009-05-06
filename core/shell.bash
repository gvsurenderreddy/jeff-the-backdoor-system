#!/bin/bash

set -e -u -o pipefail || exit 1

cd "$( dirname "${0}" )"
cd ..

JBS_HOME="${PWD}"
JBS_USER="${JBS_USER:-jeff}"
JBS_CORE="${JBS_HOME}/core"
JBS_COMMANDS="${JBS_HOME}/commands"
JBS_STORE="${JBS_HOME}/store"
JBS_SHELL="${JBS_CORE}/shell.bash"
JBS_SHELL_PY="${JBS_CORE}/shell.py"
JBS_EXEC="${JBS_CORE}/exec.bash"
JBS_TRUSTED_KEYS="${JBS_CORE}/trusted.gpg"

export JBS_HOME
export JBS_USER
export JBS_CORE
export JBS_COMMANDS
export JBS_STORE
export JBS_SHELL
export JBS_EXEC
export JBS_TRUSTED_KEYS

if test "${#}" -eq 0
then
	exec python "${JBS_SHELL_PY}"
elif test "${#}" -eq 2 && test "${1}" == '-c'
then
	exec python "${JBS_SHELL_PY}" "${2}"
fi

exit 1
