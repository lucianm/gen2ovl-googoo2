# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1445" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/skin-nopacity.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - \"nOpacity\" - hightly customizable native TrueColor Skin"
HOMEPAGE="http://projects.vdr-developer.org/projects/skin-nopacity"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.34
	media-gfx/imagemagick[png]
	net-misc/curl
	dev-libs/libxml2"
RDEPEND="${DEPEND}
	virtual/channel-logos-hq"

#PATCHES="${FILESDIR}/${PN}_..."

src_install() {
	vdr-plugin-2_src_install
	chown vdr:vdr -R "${D}"/etc/vdr
}

pkg_postinst() {
	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
	einfo "especially for the channel logos path, and in general, make sure"
	einfo "they end with an \"/\""
}
