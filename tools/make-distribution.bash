#!/bin/bash --verbose

set -e -u -o pipefail

test "${#}" -eq 0

tar -c ./core --exclude=.gitignore >./dist/jbs-core.tar
tar -c ./users --exclude=.gitignore >./dist/jbs-users.tar
tar -c ./commands --exclude=.gitignore >./dist/jbs-commands.tar

tar -c -v \
		./dist/jbs-core.tar \
		./dist/jbs-users.tar \
		./dist/jbs-commands.tar \
		./tools/install-local.bash \
		./tools/install-remote.bash \
	>./dist/jbs-dist.tar

gpg --detach-sign --armor ./dist/jbs-dist.tar

exit 0
