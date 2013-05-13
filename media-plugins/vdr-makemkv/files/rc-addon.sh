#
# rc-addon plugin-startup-script for vdr-makemkv
#
# This sript is called by gentoo-vdr-scripts on start of VDR

plugin_pre_vdr_start() {

	add_plugin_param "--makemkvcon=${MAKEMKV_PATH_BINCON:=/opt/bin/makemkvcon}"
	add_plugin_param "--svdrpsend=${MAKEMKV_PATH_SVDRPSEND:=/usr/bin/svdrpsend}"
	add_plugin_param "--device=${MAKEMKV_PATH_BDD:=/dev/sr0}"

}
