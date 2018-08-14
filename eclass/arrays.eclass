# Copyright 2016-2018 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# Usage:
#
#     CDEPEND_A=()
#     DEPEND_A=( "${CDEPEND_A[@]}" )
#     RDEPEND_A=( "${CDEPEND_A[@]}" )
#
#     inherit arrays
#


case "${EAPI:-0}" in
    6|7) ;;
    *) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


_v_a=(
	LICENSE

	SRC_URI

	KEYWORDS
	IUSE

	{C,,R,P}DEPEND

	REQUIRED_USE

	## java-*.eclass:
	CP_DEPEND
	JAVA_SRC_DIR
)
for _v in "${_v_a[@]}" ; do
	if [[ "$(declare -p ${_v}_A 2>/dev/null)" == "declare -a"* ]] ; then
		debug-print "${ECLASS}: Converting '${_v}_A' to '${_v}'"
		eval "${_v}+=\" \${${_v}_A[*]}\""

		debug-print "${ECLASS}: Unsetting '${_v}_A'"
		unset ${_v}_A
	elif [[ -v ${_v} ]] ; then
		debug-print "${ECLASS}: variable '${_v}' is not an array, but string or number!"
	fi
done
unset _v _v_a
