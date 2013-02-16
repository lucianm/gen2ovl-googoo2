# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 eutils

DESCRIPTION="VDR : CD-Player plugin with CDDB and CD-Text support"
HOMEPAGE="http://www.uli-eckhardt.de/vdr/cdplayer.en.html"
SRC_URI="http://www.uli-eckhardt.de/vdr/download/${P}.tgz"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="GPL-2"
IUSE="cdparanoia"

DEPEND=">=media-video/vdr-1.6.0
	>=dev-libs/libcdio-0.90
	cdparanoia? ( >=dev-libs/libcdio-paranoia-0.90 )
	>=media-libs/libcddb-1.3.0"

PATCHES="${FILESDIR}/${VDRPLUGIN}-${PV}_libcdio-paranoia-0.90.diff
	${FILESDIR}/${VDRPLUGIN}-${PV}_Makefile-vdr-1.7.36+.diff"

src_compile() {
	append-ldflags $(no-as-needed)
	vdr-plugin-2_src_compile
}

src_compile() {
	use cdparanoia || BUILD_PARAMS="NOPARANOIA=1"
	vdr-plugin-2_src_compile
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	dodir /etc/vdr/plugins/${VDRPLUGIN}/cddbcache
	doins "${S}"/contrib/cd.mpg
	dodoc "${S}"/contrib/cd.jpg
	dodoc "${S}"/contrib/convert.sh
	fowners -R vdr:vdr /etc/vdr/plugins/${VDRPLUGIN}
}
