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
		./tools/scan-hosts.bash \
	>./dist/jbs-dist.tar

test ! -e ./dist/jbs-dist.tar.asc || rm ./dist/jbs-dist.tar.asc

gpg --detach-sign --armor --output ./dist/jbs-dist.tar.asc ./dist/jbs-dist.tar

exit 0
