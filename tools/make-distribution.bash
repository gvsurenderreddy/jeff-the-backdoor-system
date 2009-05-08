#!/bin/bash --verbose

set -e -u -o pipefail

test "${#}" -eq 0

tar -c ./core --exclude=.gitignore >./dist/jbs-core.tar

tar -c ./users --exclude=.gitignore >./dist/jbs-users.tar

tar -c ./commands --exclude=.gitignore >./dist/jbs-commands.tar

exit 0
