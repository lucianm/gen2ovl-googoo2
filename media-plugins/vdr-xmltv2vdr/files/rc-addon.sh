#
# rc-addon-script for plugin graphlcd
#

plugin_pre_vdr_start() {
	: ${XMLTV2VDR_EPIDIR:=/var/vdr/.eplists/lists}
	: ${XMLTV2VDR_EPGFILE:=/var/vdr/video/epg.db}
	: ${XMLTV2VDR_IMGDIR:=/var/cache/vdr/epgimages}
	: ${XMLTV2VDR_LOGFILE:=}

	add_plugin_param "--episodes=${XMLTV2VDR_EPIDIR}"
	add_plugin_param "--epgfile=${XMLTV2VDR_EPGFILE}"
	add_plugin_param "--images=${XMLTV2VDR_IMGDIR}"
	add_plugin_param "--logfile=${XMLTV2VDR_LOGFILE}"
}
