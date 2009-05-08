
if test -z "${JBS_HOME:-}"
then
	pushd "$( dirname "${0}" )" >/dev/null
	cd ..
	JBS_HOME="$( pwd -P )"
	popd >/dev/null
fi

if test -z "${JBS_USER:-}"
then
	JBS_USER=jeff
fi


JBS_CORE="${JBS_HOME}/core"
JBS_USERS="${JBS_HOME}/users"
JBS_COMMANDS="${JBS_HOME}/commands"
JBS_STORE="${JBS_HOME}/store"
JBS_TMP="${JBS_HOME}/tmp"

JBS_CMD_EXEC="${JBS_CORE}/cmd_exec.bash"
JBS_CMD_SHELL="${JBS_CORE}/cmd_shell.bash"
JBS_CMD_GET="${JBS_CORE}/cmd_get.bash"
JBS_CMD_RM="${JBS_CORE}/cmd_rm.bash"
JBS_SIG_VFY="${JBS_CORE}/sig_vfy.bash"
JBS_ACL_VFY="${JBS_CORE}/acl_vfy.bash"
JBS_USR_GET="${JBS_CORE}/usr_get.bash"
JBS_USR_RM="${JBS_CORE}/usr_rm.bash"
JBS_USR_MK="${JBS_CORE}/usr_mk.bash"

JBS_SIG_KEYS="${JBS_USERS}/keys.gpg"
JBS_SSH_KEYS="${JBS_USERS}/keys.ssh"


die ()
{
	test "${#}" -eq 0 || echo "[ee] ${*}" >&2 || true
	exit 1
}

info ()
{
	test "${#}" -eq 0 || echo "[ii] ${*}" >&2 || true
	return 0
}
