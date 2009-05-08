#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 0

JBS_SSH_KEYS_NEW="${JBS_TMP}/$( uuid )"
test ! -e "${JBS_SSH_KEYS_NEW}"
touch "${JBS_SSH_KEYS_NEW}"

for TARGET_PUB in "${JBS_USERS}"/*.pub
do
	
	test -f "${TARGET_PUB}" || continue
	
	"${JBS_SIG_VFY}" "${TARGET_PUB}" || continue
	
	TARGET="$( basename "${TARGET_PUB}" .pub )"
	
	# SSH with PermitUserEnvironment enabled
	echo "environment=\"JBS_USER=${TARGET}\" $( cat "${TARGET_PUB}" )" >>"${JBS_SSH_KEYS_NEW}"
	
	# SSH with PermitUserEnvironment disabled
	# cat "${TARGET_PUB}" >>"${JBS_SSH_KEYS_NEW}"
done

cat "${JBS_SSH_KEYS_NEW}" >"${JBS_SSH_KEYS}"

rm "${JBS_SSH_KEYS_NEW}"

exit 0
