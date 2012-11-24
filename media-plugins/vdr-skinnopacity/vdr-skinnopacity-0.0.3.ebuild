# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder - nOpacity TrueColor Skin Plugin"
HOMEPAGE="http://www.vdr-portal.de/board1-news/board2-vdr-news/115810-announce-skin-nopacity/"
SRC_URI="http://projects.vdr-developer.org/attachments/download/1115/${P}.tgz
	http://minty.cirtexhosting.com/~examecom/3PO/g2v/v3/skinnopacity/icons.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.7.28
	media-gfx/imagemagick"
RDEPEND="${DEPEND}
	virtual/channel-logos-hq"

#S="${WORKDIR}/${VDRPLUGIN}-${PV}"

#VDR_RCADDON_FILE="${FILESDIR}/rc-addon-1.0.2.sh"

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/themes
	doins "${S}"/themes/*.theme

	insinto /usr/share/vdr/${VDRPLUGIN}
	rm ../icons/vdrlogo.png
	doins -r icons ../icons

	chown vdr:vdr -R "${D}"/etc/vdr
}

pkg_postinst() {
	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
	einfo "especially for the channel logos path, and in general, make sure"
	einfo "they end with an \"/\""
}
