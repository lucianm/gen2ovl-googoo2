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
	CACHEDIR_WEATHERFORECAST="${CACHEDIR}/plugins/${ADDON_SCRIPT_NAME/plugin-/}"
	if [ ! -d "${CACHEDIR_WEATHERFORECAST}" ]; then
		mkdir -p ${CACHEDIR_WEATHERFORECAST}
		chown vdr:vdr ${CACHEDIR_WEATHERFORECAST}
	fi
}

plugin_pre_vdr_start() {
	init_cache_dir
}
