#!/bin/bash

set -e -u -o pipefail || exit 1

die ()
{
	test "${#}" -eq 0 || echo "${*}" >&2 || true
	exit 1
}

test "${#}" -ge 1 || die '[ee] empty command; aborting!'


JBS_COMMAND="${1}"
JBS_COMMAND_BASH="${JBS_COMMANDS}/${1}.bash"
JBS_COMMAND_ASC="${JBS_COMMAND_BASH}.asc"
JBS_COMMAND_ACL="${JBS_COMMAND_BASH}.acl"

if test "${#}" -eq 1
then
	JBS_COMMAND_ARGUMENTS=()
else
	JBS_COMMAND_ARGUMENTS=( "${@:2}" )
fi

test -f "${JBS_COMMAND_BASH}" || die '[ee] command script not found; aborting!'

test -f "${JBS_COMMAND_ASC}" || die '[ee] command signature not found; aborting!'

test -f "${JBS_COMMAND_ACL}" || die '[ee] command acl not found; aborting!'

gpg \
		--verify \
		--no-default-keyring \
		--keyring "${JBS_TRUSTED_KEYS}" \
		"${JBS_COMMAND_ASC}" \
	2>/dev/null \
|| die '[ee] command signature failed; aborting!'

grep \
		-F "${JBS_USER}" \
		"${JBS_COMMAND_ACL}" \
	>/dev/null \
|| die '[ee] command acl failed; aborting!'

if test "${#JBS_COMMAND_ARGUMENTS}" -eq 0
then
	exec bash "${JBS_COMMAND_BASH}"
else
	exec bash "${JBS_COMMAND_BASH}" "${JBS_COMMAND_ARGUMENTS[@]}"
fi

exit 1
