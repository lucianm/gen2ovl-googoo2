# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder - Plugin for playing BluRays with the help of MakeMKV"
HOMEPAGE="http://www.vdr-portal.de/board17-developer/board21-vdr-plugins/118629-makemkv-0-0-2-bluray-wiedergabe-mit-dem-vdr/"
SRC_URI="vdr-plugin-${VDRPLUGIN}_${PV}.orig.tar.gz de_DE.po.tgz"

RESTRICT="fetch"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-2.0.0"
RDEPEND="${DEPEND}
	media-video/makemkv"

S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"

PATCHES="${FILESDIR}/${P}_fix.patch"

src_unpack() {
	cd "${DISTDIR}"
	cd "${WORKDIR}"
	unpack "vdr-plugin-${VDRPLUGIN}_${PV}.orig.tar.gz"
	cd "${S}/po"
	unpack "de_DE.po.tgz"
}

pkg_nofetch() {
	einfo "Please download the attachments"
	einfo "'http://www.vdr-portal.de/index.php?page=Attachment&attachmentID=33564&h=69b73c26dc449d1e00e4f9f7e2212872592b87ed' and"
	einfo "'http://www.vdr-portal.de/index.php?page=Attachment&attachmentID=33570&h=dfb7f3e6d78c0f779f17fd3954b45667cad4ec6b'"
	einfo "from 'http://www.vdr-portal.de/board17-developer/board21-vdr-plugins/118629-makemkv-0-0-2-bluray-wiedergabe-mit-dem-vdr/'"
	einfo "with a web browser and place them in ${DISTDIR} renamed"
	einfo "EXACTLY as '${SRC_URI}' !!!"
}
