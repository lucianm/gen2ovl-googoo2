# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: make osd menu configurable via config-file"
HOMEPAGE="https://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"
SRC_URI="mirror://vdr-developerorg/1312/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND=">=media-video/vdr-1.5.18[${VDRPLUGIN}]
	dev-cpp/libxmlpp:2.6
	dev-cpp/glibmm"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare
	sed -e "s:o=%.c:o=%.cpp:" -i Makefile || die
	sed -e "s:cxxflags):cxxflags) -std=gnu++11:" -i Makefile || die
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins menuorg.xml
}
