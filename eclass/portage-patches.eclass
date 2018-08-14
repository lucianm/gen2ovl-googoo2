# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: portage-patches.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: Set of portage functions overrides intended to be used anywhere
# @DESCRIPTION:

case "${EAPI:-0}" in
    5|6) ;;
    *) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


## Origin: portage - bin/isolated-functions.sh
## PR: https://github.com/gentoo/portage/pull/26
rindeal::has() {
	local needle="${1}" ; shift
	local haystack=( "$@" )

	local IFS=$'\a'

	## wrap every argument in IFS
	needle="${IFS}${needle}${IFS}"
	haystack=( "${haystack[@]/#/${IFS}}" )
	haystack=( "${haystack[@]/%/${IFS}}" )

	[[ "${haystack[*]}" == *"${needle}"* ]]
}
has() { rindeal::has "${@}" ; }

rindeal::has_version() {
	local atom eroot host_root=false root=${ROOT}
	if [[ $1 == --host-root ]] ; then
		host_root=true
		shift
	fi
	atom=$1
	shift
	[ $# -gt 0 ] && die "${FUNCNAME[0]}: unused argument(s): $*"

	if ${host_root} ; then
		if ! ___eapi_best_version_and_has_version_support_--host-root; then
			die "${FUNCNAME[0]}: option --host-root is not supported with EAPI ${EAPI}"
		fi
		root=/
	fi

	if ___eapi_has_prefix_variables; then
		# [[ ${root} == / ]] would be ambiguous here,
		# since both prefixes can share root=/ while
		# having different EPREFIX offsets.
		if ${host_root} ; then
			eroot=${root%/}${PORTAGE_OVERRIDE_EPREFIX}/
		else
			eroot=${root%/}${EPREFIX}/
		fi
	else
		eroot=${root}
	fi

	sh -c "unset EBUILD_PHASE EAPI; '${PORTAGE_BIN_PATH}/ebuild-helpers/portageq' has_version '${eroot}' '${atom}'"
	local retval=$?
	case "${retval}" in
		0|1)
			return ${retval}
			;;
		2)
			die "${FUNCNAME[0]}: invalid atom: ${atom}"
			;;
		*)
			if [[ -n ${PORTAGE_IPC_DAEMON} ]]; then
				die "${FUNCNAME[0]}: unexpected ebuild-ipc exit code: ${retval}"
			else
				die "${FUNCNAME[0]}: unexpected portageq exit code: ${retval}"
			fi
			;;
	esac
}
has_version() { rindeal::has_version "${@}" ; }
