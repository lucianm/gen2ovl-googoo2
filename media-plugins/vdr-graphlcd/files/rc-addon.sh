#
# rc-addon-script for plugin graphlcd
#

plugin_pre_vdr_start() {
	: ${GRAPHLCD_DRVCFG:=/etc/vdr/plugins/graphlcd/graphlcd.conf}
	: ${GRAPHLCD_DISPLAY:=t6963c}
	: ${GRAPHLCD_SKINSPATH:=/usr/share/vdr/plugins/graphlcd/skins}
	: ${GRAPHLCD_SKIN:=default}

	add_plugin_param "-c ${GRAPHLCD_DRVCFG}"
	add_plugin_param "-d ${GRAPHLCD_DISPLAY}"
	add_plugin_param "-p ${GRAPHLCD_SKINSPATH}"
	add_plugin_param "-s ${GRAPHLCD_SKIN}"
}
