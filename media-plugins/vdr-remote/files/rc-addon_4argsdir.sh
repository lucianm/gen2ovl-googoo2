#
# rc-addon-script for plugin remote
#

check_device() {
	local handlers="${1}"
	local name="${2}"
	local eventdev=""
	[ "${handlers}" = "" ] && return

	local handler
	for handler in ${handlers}; do
		case "${handler}" in
		event*)
			eventdev=${handler}
			;;
		esac
	done

	if [ "${eventdev}" = "" ]; then
		if [ "${evdev_warning_showed}" != "1" ]; then
			echo "you need to load module evdev for autodetect input-devices to work"
			evdev_warning_showed=1
		fi
		return
	fi

	case "${name}" in
		*dvb*|*DVB*)
			einfo_level1 "Autodetect Input Device ${eventdev} (Name: ${name})"
			REMOTE_PLUGIN_INPUT_DEVICE="${REMOTE_PLUGIN_INPUT_DEVICE} /dev/input/${eventdev}"
		;;
	esac
}

autodetect_input_devices() {
	[ -e /proc/bus/input/devices ] || return
	exec 3</proc/bus/input/devices
	while read -u 3 line; do
		case ${line} in
		I:*)	check_device "${device}" "${name}" 
			device=""
			;;
		H:*)	device=${line#H: Handlers=}
			;;
		N:*)	name=${line#N: Name=\"}
			name=${name%\"}
			;;
		esac
	done
	check_device "${device}" "${name}"
	exec 3<&-
}

plugin_pre_vdr_start() {
	# read from /etc/vdr/conf.avail/osdteletext.conf if the proper g-v-s installed:
	argsdir_funcs="/usr/share/vdr/inc/argsdir-functions.sh"
	if [ -f "${argsdir_funcs}" ]; then
		source ${argsdir_funcs}
		REMOTE_PLUGIN_INPUT_DEVICE="$(get_cfg_opt remote --input -i)"
#		REMOTE_PLUGIN_LIRC="$(get_cfg_opt remote --lirc -l)"
#		REMOTE_PLUGIN_TCP_PORTS="$(get_cfg_opt remote --port -p)"
		REMOTE_PLUGIN_TTY_ONLY_INPUT="$(get_cfg_opt remote --tty -t)"
		REMOTE_PLUGIN_TTY_WITH_OSD="$(get_cfg_opt remote --TTY -T)"
	fi


	if [ "${REMOTE_PLUGIN_INPUT_DEVICE:-autodetect}" = "autodetect" ]; then
		REMOTE_PLUGIN_INPUT_DEVICE=""
		autodetect_input_devices
	fi
	if [ -n "${REMOTE_PLUGIN_INPUT_DEVICE}" ] && [ "${REMOTE_PLUGIN_INPUT_DEVICE}" != "no" ]; then
		[ -e /proc/av7110_ir ] && chown vdr:vdr /proc/av7110_ir
		for dev in ${REMOTE_PLUGIN_INPUT_DEVICE}; do
			[ -e "${dev}" ] || continue
			chown vdr:vdr ${dev}
		done
	fi

	if [ -n "${REMOTE_PLUGIN_TTY_ONLY_INPUT}" ]; then
		for tty in ${REMOTE_PLUGIN_TTY_ONLY_INPUT}; do
			[ -e "${tty}" ] || continue
			chown vdr:vdr ${tty}
		done
	fi

	if [ -n "${REMOTE_PLUGIN_TTY_WITH_OSD}" ]; then
		for tty in ${REMOTE_PLUGIN_TTY_WITH_OSD}; do
			[ -e "${tty}" ] || continue
			chown vdr:vdr ${tty}
		done
	fi
}
