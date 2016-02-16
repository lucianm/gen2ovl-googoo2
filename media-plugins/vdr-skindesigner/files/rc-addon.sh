# $Header: Exp $
#
# rc-addon-script for plugin skindesigner
#

# this is from /etc/conf.d/vdr
: ${CACHEDIR:=/var/cache/vdr}

# depends on QA, create paths in /var/cache on the fly at runtime as needed
init_cache_dir() {
	local ADDON_SCRIPT_NAME="$(basename $0)"
	local PLUGIN_CACHEDIR="${CACHEDIR}/plugins/${ADDON_SCRIPT_NAME/plugin-/}"
	if [ ! -d "${PLUGIN_CACHEDIR}" ]; then
		mkdir -p ${PLUGIN_CACHEDIR}
		chown vdr:vdr ${PLUGIN_CACHEDIR}
	fi
}

plugin_pre_vdr_start() {
	init_cache_dir
	add_plugin_param "--skinpath=${SKINDESIGNER_SKINPATH:=/usr/share/vdr/plugins/skindesigner/skins/}"
	add_plugin_param "--installerpath=${SKINDESIGNER_INSTALLERPATH:=/etc/vdr/plugins/skindesigner/skins/}"
	add_plugin_param "--logopath=${SKINDESIGNER_LOGOPATH:=/usr/share/vdr/plugins/skindesigner/logos/}"
	add_plugin_param "--epgimages=${SKINDESIGNER_EPGIMAGESPATH:=/var/cache/vdr/epgimages/}"
}
