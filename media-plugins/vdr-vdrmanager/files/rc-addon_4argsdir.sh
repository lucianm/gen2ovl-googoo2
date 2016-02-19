#
# rc-addon plugin-startup-script for vdr-vdrmanager
#


plugin_pre_vdr_start() {

	# read from /etc/vdr/conf.avail/osdteletext.conf if the proper g-v-s installed:
	argsdir_funcs="/usr/share/vdr/inc/argsdir-functions.sh"
	if [ -f "${argsdir_funcs}" ]; then
		source ${argsdir_funcs}
		VDRMANAGER_PASS="$(get_cfg_opt vdrmanager --password -P)"
	fi

	if [[ -z ${VDRMANAGER_PASS} ]]; then
		eerror "Empty password in /etc/vdr/conf.avail/vdrmanager.conf"
		logger -t vdr "ERROR: need password for plugin vdr-manager"
	fi
}
