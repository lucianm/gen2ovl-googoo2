# $Header: Exp $
#
# rc-addon-script for plugin skindesigner
#

plugin_pre_vdr_start() {
  add_plugin_param "--skinpath=${SKINDESIGNER_SKINSDIR:=/usr/share/vdr/plugins/skindesigner/skins/}"
  add_plugin_param "--epgimages=${SKINDESIGNER_EPGIMGDIR:=/var/cache/vdr/epgimages/}"
}
