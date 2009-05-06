#!/bin/bash

set -e -u -o pipefail || exit 1

. "${JBS_HOME}"/core/internals.bash

test "${#}" -eq 1

exec "${JBS_GET_CMD}" "${1}"
exit 1
