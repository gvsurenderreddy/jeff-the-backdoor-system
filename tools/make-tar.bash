#!/bin/bash --verbose

set -e -u -o pipefail

test "${#}" -eq 0

git archive --format=tar HEAD core >./dist/jbs-core.tar

tar -c ./users --exclude=.gitignore >./dist/jbs-users.tar

tar -c ./commands --exclude=.gitignore >./dist/jbs-commands.tar

exit 0
