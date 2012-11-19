# $Header: Exp $
#
# rc-addon-script for plugin skinnopacity
#

SKINNOPACITY_ICONDIR="/usr/share/vdr/skinnopacity/icons/"
SKINNOPACITY_LOGODIR="/usr/share/channel-logos/dvbviewer/"
SKINNOPACITY_EPGIMGDIR="/video/epg_image_cache/"

plugin_pre_vdr_start() {
  add_plugin_param "--iconpath=${SKINNOPACITY_ICONDIR}"
  add_plugin_param "--logopath=${SKINNOPACITY_LOGODIR}"
  add_plugin_param "--epgimages=${SKINNOPACITY_EPGIMGDIR}"
}
