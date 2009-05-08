#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 0

sudo poweroff

echo ok

exit 0
