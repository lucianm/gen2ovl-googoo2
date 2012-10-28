# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: video website browser / viewer"
HOMEPAGE="http://users.tkk.fi/~aajanki/vdr/webvideo/"
SRC_URI="http://projects.vdr-developer.org/attachments/download/1057/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
	=media-video/webvi-${PV}"

S="${WORKDIR}/${VDRPLUGIN}-${PV}/src/vdr-plugin"

src_install() {

	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins mime.types
	cd ${WORKDIR}/${VDRPLUGIN}-${PV}
	dodoc -r README.vdrplugin TODO HISTORY doc

}
