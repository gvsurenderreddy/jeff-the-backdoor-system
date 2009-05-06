#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_HOME:-}" ; then . "${JBS_HOME}/core/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 1

TARGET_ACL="${1}"

test -f "${TARGET_ACL}" || die "target acl {{${TARGET_ACL}}} not found!"

grep \
		-F "${JBS_USER}" \
		"${TARGET_ACL}" \
	>/dev/null \
|| die "target acl {{${TARGET_ACL}}} mismatch!"

exit 0
