# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="yaepghd plugin for nice epg"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-yaepghd"
#SRC_URI="http://sourceforge.net/projects/vdrplugins/files/${P}.tgz
#	mirror://vdrfiles/${P}/${P}.tgz"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=">=media-video/vdr-1.7.33"
DEPEND="${RDEPEND}"

src_install() {
	vdr-plugin-2_src_install

	dodir /etc/vdr/plugins || die
	insinto /etc/vdr/plugins
	doins -r yaepghd || die
	fowners -R vdr:vdr /etc/vdr || die
}
