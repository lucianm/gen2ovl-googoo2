# $Id$
#
# rc-addon-script for plugin weatherforecast
#
# Lucian Muresan <lucianm@users.sourceforge.net>

# this is from /etc/conf.d/vdr
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
