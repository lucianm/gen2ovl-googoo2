# $Header: Exp $
#
# rc-addon-script for plugin tvguide
#

TVGUIDE_LOGODIR="/usr/share/channel-logos/dvbviewer/"
TVGUIDE_EPGIMGDIR="/video/epg_image_cache/"

plugin_pre_vdr_start() {
  add_plugin_param "--logodir=${TVGUIDE_LOGODIR}"
  add_plugin_param "--epgimages=${TVGUIDE_EPGIMGDIR}"
}
