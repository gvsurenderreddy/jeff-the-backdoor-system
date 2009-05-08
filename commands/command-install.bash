#!/bin/bash

set -e -u -o pipefail || exit 1

. "${JBS_CORE}/internals.bash"

test "${#}" -eq 1

exec "${JBS_CMD_GET}" "${1}"
exit 1
