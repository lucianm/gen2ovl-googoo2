# $Header: $
#
# rc-addon-script for plugin softhddevice
#
# Martin Dummer <martin.dummer@gmx.net>

: ${SOFTHDDEVICE_AUDIO_DEVICE:="hw:0,0"}
: ${SOFTHDDEVICE_AUDIO_MIXERCHANNEL:=PCM}
: ${SOFTHDDEVICE_VIDEO_DISPLAY:=":0.0"}
: ${SOFTHDDEVICE_VIDEO_DEVICE:=vaapi}
: ${SOFTHDDEVICE_VIDEO_START_X11SERVER:=no}
: ${SOFTHDDEVICE_VIDEO_X11SERVER_ARGS:=""}
: ${SOFTHDDEVICE_VIDEO_START_FULLSCREEN:=no}
: ${SOFTHDDEVICE_START_SUSPENDED:=no}
: ${SOFTHDDEVICE_START_DETACHED:=no}
: ${SOFTHDDEVICE_WORKAROUNDS:=""}

plugin_pre_vdr_start() {
	local Workaround=""

	add_plugin_param "-d ${SOFTHDDEVICE_VIDEO_DISPLAY} "
	if [ "${SOFTHDDEVICE_VIDEO_DEVICE}" = "vaapi" ]; then
		SOFTHDDEVICE_VIDEO_DEVICE="va-api"
	fi
	add_plugin_param "-v ${SOFTHDDEVICE_VIDEO_DEVICE} "
	add_plugin_param "-a ${SOFTHDDEVICE_AUDIO_DEVICE} "

	if [ -n "${SOFTHDDEVICE_AUDIO_PASSTHROUGHDEVICE}" ]; then
		add_plugin_param "-p ${SOFTHDDEVICE_AUDIO_PASSTHROUGHDEVICE} "
	fi
	if [ "${SOFTHDDEVICE_AUDIO_MIXERCHANNEL}" != "PCM" ]; then
		add_plugin_param "-c ${SOFTHDDEVICE_AUDIO_MIXERCHANNEL} "
	fi
	if [ "${SOFTHDDEVICE_VIDEO_START_X11SERVER}" = "yes" ]; then
		add_plugin_param "-x "
	fi
	if [ -n "${SOFTHDDEVICE_VIDEO_X11SERVER_ARGS}" ]; then
		add_plugin_param "-X ${SOFTHDDEVICE_VIDEO_X11SERVER_ARGS} "
	fi
	if [ "${SOFTHDDEVICE_VIDEO_START_FULLSCREEN}" = "yes" ]; then
		add_plugin_param "-f "
	fi
	if [ -n "${SOFTHDDEVICE_VIDEO_GEOMETRY}" ]; then
		add_plugin_param "-g ${SOFTHDDEVICE_VIDEO_GEOMETRY} "
	fi
	if [ "${SOFTHDDEVICE_START_SUSPENDED}" = "yes" ]; then
		add_plugin_param "-s "
	fi
	if [ "${SOFTHDDEVICE_START_DETACHED}" = "yes" ]; then
		add_plugin_param "-D "
	fi
	for Workaround in ${SOFTHDDEVICE_WORKAROUNDS}; do
		add_plugin_param "-w ${Workaround} "
	done
}
