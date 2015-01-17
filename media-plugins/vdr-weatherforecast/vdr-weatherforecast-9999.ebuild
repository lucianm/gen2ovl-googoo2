# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1402" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - \"WeatherForecast\" provides a weather forecast \(who'd have thought? \;\) ) based on forecast.io data"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.28
	net-misc/curl
	dev-libs/jansson"

RDEPEND="${DEPEND}"

#VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
#VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

#PATCHES="${FILESDIR}/.."

src_install() {
	vdr-plugin-2_src_install
	#chown vdr:vdr -R "${D}"/etc/vdr
	WEATHERFORECAST_CACHEDIR="/var/cache/vdr/plugins/${VDRPLUGIN}"
	dodir "${WEATHERFORECAST_CACHEDIR}"
	fowners -R vdr:vdr "${WEATHERFORECAST_CACHEDIR}"
}

#pkg_postinst() {
#	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
#	einfo "especially for the channel logos path, and in general, make sure"
#	einfo "they end with an \"/\""
#}
