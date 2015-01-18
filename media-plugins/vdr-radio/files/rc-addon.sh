# $Header: Exp $
#
# rc-addon plugin-startup-script for vdr-radio
#
# This sript is called by gentoo-vdr-scripts on start of VDR

plugin_pre_vdr_start() {

    : ${RADIO_FILES_DIR:=/etc/vdr/plugins/radio}
    : ${RADIO_DATA_DIR:=/var/cache/vdr/plugins/radio}
    : ${RADIO_LIVE_FILE:=radio-Tubes1080.mpg}
    : ${RADIO_REPLAY_FILE:=rtextUnten-kleo2-replay.mpg}
    : ${RADIO_ENCRYPTED:=0}
    : ${RADIO_LOG_LEVEL:=1}

    add_plugin_param "--files=${RADIO_FILES_DIR}"
    add_plugin_param "--data=${RADIO_DATA_DIR}"
    add_plugin_param "--live=${RADIO_LIVE_FILE}"
    add_plugin_param "--replay=${RADIO_REPLAY_FILE}"
    add_plugin_param "--encrypted=${RADIO_ENCRYPTED}"
    add_plugin_param "--verbose=${RADIO_LOG_LEVEL}"

}
