#!/bin/bash

set -e -u -o pipefail

test "${#}" -eq 0

git archive --format=tar --prefix=.jbs/  HEAD >./jbs.tar

exit 0
