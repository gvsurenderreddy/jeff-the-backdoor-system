#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 0

cd /users

sudo find . -name '*.lsp' -print | tar -c -T /dev/stdin

exit 0
