#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 0

for TARGET in "${JBS_COMMANDS}"/*.bash
do
	
	test -f "${TARGET}" || continue
	
	TARGET_ACL="${TARGET}.acl"
	
	TARGET_MD5="$( md5sum -t <"${TARGET}" )"
	
	test -f "${TARGET_ACL}" && grep -F -e "${TARGET_MD5}" "${TARGET_ACL}" >/dev/null && continue
	
	TARGET_ACL_NEW="${JBS_TMP}/$( uuid )"
	test ! -e "${TARGET_ACL_NEW}"
	
	info "making acl for {{${TARGET}}}..."
	
	(
		echo "${TARGET_MD5}"
		grep -v -E -e '^[0-9a-f]{32}  -$' "${TARGET_ACL}"
		exit 0
	) >"${TARGET_ACL_NEW}"
	
	mv "${TARGET_ACL_NEW}" "${TARGET_ACL}"
	
done

exit 0
