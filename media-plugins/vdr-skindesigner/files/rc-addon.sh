# $Header: Exp $
#
# rc-addon-script for plugin skindesigner
#

: ${SKINDESIGNERCACHE_DIR:=/var/cache/vdr/plugins/skindesigner}

# depends on QA, create paths in /var/cache on the fly at runtime as needed
init_cache_dir() {
	if [ ! -d "${SKINDESIGNERCACHE_DIR}" ]; then
		mkdir -p ${SKINDESIGNERCACHE_DIR}
		chown vdr:vdr ${SKINDESIGNERCACHE_DIR}
	fi
}


plugin_pre_vdr_start() {
	init_cache_dir
	add_plugin_param "--skinpath=${SKINDESIGNER_SKINPATH:=/usr/share/vdr/plugins/skindesigner/skins/}"
	add_plugin_param "--installerpath=${SKINDESIGNER_INSTALLERPATH:=/etc/vdr/plugins/skindesigner/skins/}"
	add_plugin_param "--logopath=${SKINDESIGNER_LOGOPATH:=/usr/share/vdr/plugins/skindesigner/logos/}"
	add_plugin_param "--epgimages=${SKINDESIGNER_EPGIMAGESPATH:=/var/cache/vdr/epgimages/}"
}
