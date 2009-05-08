#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 1

TARGET="${1}"
TARGET_ASC="${TARGET}.asc"

test -f "${TARGET}" || die "target {{${TARGET}}} not found!"
test -f "${TARGET_ASC}" || die "target signature {{${TARGET_ASC}}} not found!"

gpg \
		--verify \
		--no-default-keyring \
		--keyring "${JBS_SIG_KEYS}" \
		"${TARGET_ASC}" \
	2>/dev/null \
|| die "target signature {{${TARGET_ASC}}} mismatch!"

exit 0
