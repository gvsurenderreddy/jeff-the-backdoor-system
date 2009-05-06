
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

JBS_EXEC="${JBS_CORE}/exec.bash"
JBS_SHELL="${JBS_CORE}/shell.bash"
JBS_VFY_SIG="${JBS_CORE}/vfy_sig.bash"
JBS_VFY_ACL="${JBS_CORE}/vfy_acl.bash"
JBS_GET_CMD="${JBS_CORE}/get_cmd.bash"

JBS_KEYS="${JBS_CORE}/keys.gpg"
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
