# $Header: Exp $
#
# rc-addon-script for plugin tvguide
#

plugin_pre_vdr_start() {
  add_plugin_param "--logodir=${TVGUIDE_LOGODIR:=/usr/share/channel-logos/dvbviewer/}"
  add_plugin_param "--epgimages=${TVGUIDE_EPGIMGDIR:=/video/epg_image_cache/}"
}
