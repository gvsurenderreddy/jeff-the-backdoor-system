#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 0

for TARGET in "${JBS_COMMANDS}"/*.bash "${JBS_COMMANDS}"/*.bash.acl "${JBS_USERS}"/*.pub
do
	
	test -f "${TARGET}" || continue
	
	TARGET_ASC="${TARGET}.asc"
	
	test -f "${TARGET_ASC}" && gpg --verify "${TARGET_ASC}" 2>/dev/null && continue
	
	TARGET_ASC_NEW="${JBS_TMP}/$( uuid )"
	test ! -e "${TARGET_ASC_NEW}"
	
	info "making signature for {{${TARGET}}}..."
	
	gpg --detach-sign --armor --output "${TARGET_ASC_NEW}" "${TARGET}"
	
	mv "${TARGET_ASC_NEW}" "${TARGET_ASC}"
	
done

exit 0
