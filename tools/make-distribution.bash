#!/bin/bash --verbose

set -e -u -o pipefail

test "${#}" -eq 0

tar -c ./core --exclude=.gitignore >./dist/jbs-core.tar
tar -c ./users --exclude=.gitignore >./dist/jbs-users.tar
tar -c ./commands --exclude=.gitignore >./dist/jbs-commands.tar

cp ./tools/install-local.bash ./dist
cp ./tools/install-remote.bash ./dist

tar -C ./dist -c . --exclude=jbs-dist.tar -v >./dist/jbs-dist.tar

gpg --detach-sign --armor ./dist/jbs-dist.tar

exit 0
