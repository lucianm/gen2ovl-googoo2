# $Header: Exp $
#
# rc-addon-script for plugin skinnopacity
#

plugin_pre_vdr_start() {
  add_plugin_param "--iconpath=${SKINNOPACITY_ICONDIR:=/usr/share/vdr/plugins/skinnopacity/icons/}"
  add_plugin_param "--logopath=${SKINNOPACITY_LOGODIR:=/usr/share/channel-logos/dvbviewer/}"
  add_plugin_param "--epgimages=${SKINNOPACITY_EPGIMGDIR:=/var/cache/vdr/epgimages/}"
}
