#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 0

sudo find /users -mindepth 1 -delete

echo ok

exit 0
