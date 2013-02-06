# $Header: Exp $
#
# rc-addon-script for plugin skinenigmang
#
# Joerg Bornkessel hd_brummy@gentoo.org

SKINENIGMANG_LOGODIR="/usr/share/channel-logos/enigmang"
SKINENIGMANG_EPGIMGDIR="/var/cache/vdr/epgimages"

plugin_pre_vdr_start() {
  add_plugin_param "--logodir=${SKINENIGMANG_LOGODIR}"
  add_plugin_param "--epgimages=${SKINENIGMANG_EPGIMGDIR}"
}
