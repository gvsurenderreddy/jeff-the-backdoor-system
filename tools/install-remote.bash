#!/bin/bash

set -e -u -o pipefail

test "${#}" -eq 1


ssh "${1}" /bin/bash --verbose <./tools/install-local.bash

exit 0
