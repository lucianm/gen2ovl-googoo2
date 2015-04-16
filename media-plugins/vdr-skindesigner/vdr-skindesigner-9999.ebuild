# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1803" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - \"${VDRPLUGIN}\" - modern text2skin-like engine to display XML based skins"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-2.0.0
	media-gfx/imagemagick[png,jpeg]
	net-misc/curl
	dev-libs/libxml2
	>=media-plugins/vdr-softhddevice-0.6.0
	>=media-plugins/vdr-epgsearch-1.0.1
	media-fonts/vdropensans-ttf"
RDEPEND="${DEPEND}
	virtual/channel-logos-hq"

#PATCHES="${FILESDIR}/${PN}_..."

SKINDESIGNER_CACHEDIR="/var/cache/vdr/plugins/${VDRPLUGIN}"

src_prepare() {
	vdr-plugin-2_src_prepare

	# adjust plugin cache ND SCRIPT directories:
	chmod -R ugo+x ${S}/scripts/temperatures*	
	for script in config.h $(ls ${S}/scripts/temperatures*); do
		sed -i "s:/tmp/${VDRPLUGIN}:${SKINDESIGNER_CACHEDIR}:" $script || die
	done
	BUILD_PARAMS+=" PREFIX=/usr SKINDESIGNER_SCRIPTDIR=/etc/vdr/plugins/${VDRPLUGIN}/scripts"
}

src_install() {
	vdr-plugin-2_src_install
	fowners -R vdr:vdr /etc/vdr	
	dodir "${SKINDESIGNER_CACHEDIR}"
	fowners -R vdr:vdr "${SKINDESIGNER_CACHEDIR}"
}

pkg_postinst() {
	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
	einfo "especially for the channel logos path, and in general, make sure"
	einfo "they end with an \"/\""
	einfo ""
	einfo "Please also check /etc/vdr/plugins/${VDRPLUGIN}/scripts/README !!!"
}
