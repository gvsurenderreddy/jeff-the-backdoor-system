#!/bin/bash

set -e -u -o pipefail || exit 1

test "${#}" -eq 1

nmap -sP -n "${1}" -oG /dev/stdout --host-timeout 30000 \
| grep -E -e 'Status: Up' \
| grep -o -E -e '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'

exit 0
