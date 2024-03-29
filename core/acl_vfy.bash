#!/bin/bash

set -e -u -o pipefail || exit 1

if test -n "${JBS_CORE:-}" ; then . "${JBS_CORE}/internals.bash" ; else . "$( dirname "${0}" )/internals.bash" ; fi

test "${#}" -eq 1

TARGET="${1}"
TARGET_ACL="${1}.acl"

test -f "${TARGET}" || die "target {{${TARGET}}} not found!"
test -f "${TARGET_ACL}" || die "target acl {{${TARGET_ACL}}} not found!"

TARGET_MD5="$( md5sum -t <"${TARGET}" )"

test -n "${JBS_USER_OVERRIDE:-}" || exit 0

grep -F -e "${TARGET_MD5}" "${TARGET_ACL}" >/dev/null || die "target acl md5 {{${TARGET_ACL}}} mismatch!"

grep -F -e "${JBS_USER}" -e '*' "${TARGET_ACL}" >/dev/null || die "target acl user {{${TARGET_ACL}}} mismatch!"

exit 0
