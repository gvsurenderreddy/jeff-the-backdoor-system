#!/bin/bash

set -e -u -o pipefail || exit 1

test "${0}" == ./core/sign.bash || exit 1
test "${#}" -eq 1 || exit 1

cd ./commands || exit 1

case "${1}" in
	
	( all )
		
		for file in *.bash
		do
			echo "[ii] processing ${file}..." >&2 || true
			echo "[ii] verifing signature..." >&2 || true
			{ test -f "${file}.asc" && gpg --verify "./${file}.asc" 2>/dev/null && continue ; } || true
			echo "[ii] signing signature..." >&2 || true
			gpg --detach-sign --armor "./${file}" || exit 1
		done
		exit 0
	;;
	
	( * )
		file="${1}.bash"
			echo "[ii] processing ${file}..." >&2 || true
			echo "[ii] verifing signature..." >&2 || true
		{ test -f "${file}.asc" && gpg --verify "./${file}.asc" 2>/dev/null && continue ; } || true
		echo "[ii] signing signature..." >&2 || true
		gpg --detach-sign --armor "./${file}" || exit 1
		exit 0
	;;
	
esac

exit 1
