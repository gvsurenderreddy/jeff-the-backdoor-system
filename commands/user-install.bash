#!/bin/bash

set -e -u -o pipefail || exit 1

. "${JBS_CORE}/internals.bash"

test "${#}" -ne 0

exec "${JBS_USR_GET}" "${@}"
exit 1
