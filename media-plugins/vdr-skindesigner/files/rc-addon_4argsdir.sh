# $Header: Exp $
#
# rc-addon-script for plugin skindesigner
#

# read from /etc/vdr/conf.avail/vdr.conf if the proper g-v-s installed:
argsdir_funcs="/usr/share/vdr/inc/argsdir-functions.sh"
if [ -f "${argsdir_funcs}" ]; then
	source ${argsdir_funcs}
	CACHEDIR="$(get_cfg_opt vdr --cachedir)"
fi
# if no custom value, use standard
: ${CACHEDIR:=/var/cache/vdr}

# depends on QA, create paths in /var/cache on the fly at runtime as needed
init_cache_dir() {
	ADDON_SCRIPT_NAME="$(basename $0)"
	local PLUGIN_CACHEDIR="${CACHEDIR}/plugins/${ADDON_SCRIPT_NAME/plugin-/}"
	if [ ! -d "${PLUGIN_CACHEDIR}" ]; then
		mkdir -p ${PLUGIN_CACHEDIR}
		chown vdr:vdr ${PLUGIN_CACHEDIR}
	fi
}


plugin_pre_vdr_start() {
	init_cache_dir
}
