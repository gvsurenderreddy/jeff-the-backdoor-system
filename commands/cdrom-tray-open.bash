#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 0

sudo eject

echo ok

exit 0
