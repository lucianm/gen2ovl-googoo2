# $Header: Exp $
#
# rc-addon-script for plugin scraper2vdr
#

plugin_pre_vdr_start() {
  add_plugin_param "--imagedir=${SCRAPER2VDR_IMGDIR:=/var/cache/vdr/epgimages/}"
  add_plugin_param "--mode=${SCRAPER2VDR_MODE:=client}"
}
