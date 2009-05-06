#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_HOME:-}" ; then . "${JBS_HOME}/core/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 0

for TARGET in "${JBS_COMMANDS}"/*.bash "${JBS_COMMANDS}"/*.bash.acl "${JBS_USERS}"/*.pub
do
	test -f "${TARGET}" || continue
	test ! -f "${TARGET}.asc" || ! gpg --verify "${TARGET}.asc" 2>/dev/null || continue
	info "signing target {{${TARGET}}}..."
	gpg --detach-sign --armor "${TARGET}"
done

exit 0
