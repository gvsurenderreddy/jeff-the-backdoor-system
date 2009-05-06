#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_HOME:-}" ; then . "${JBS_HOME}/core/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 0

JBS_SSH_KEYS_NEW="$( uuid )"
test ! -e "${JBS_SSH_KEYS_NEW}"
touch "${JBS_SSH_KEYS_NEW}"

for USER_KEY in "${JBS_USERS}"/*.pub
do
	test -f "${USER_KEY}" || continue
	"${JBS_VFY_SIG}" "${USER_KEY}" || continue
	USER="$( basename "${USER_KEY}" .pub )"
	echo "environment=\"JBS_USER=${USER}\" $( cat "${USER_KEY}" )" >>"${JBS_SSH_KEYS_NEW}"
	cat "${USER_KEY}" >>"${JBS_SSH_KEYS_NEW}"
done

cat "${JBS_SSH_KEYS_NEW}" >"${JBS_SSH_KEYS}"

rm "${JBS_SSH_KEYS_NEW}"

exit 0
