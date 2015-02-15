# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 eutils

DESCRIPTION="VDR : Control CEC-enabled devices with the VDR remote"
HOMEPAGE="http://www.uli-eckhardt.de/vdr/cecremote.en.html"
if [ "${PV}" = "9999" ]; then
	inherit mercurial
	EHG_REPO_URI="http://hg.uli-eckhardt.de/cecremote"
	EHG_REVISION="tip"
	KEYWORDS=""
else
	SRC_URI="http://www.uli-eckhardt.de/vdr/download/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="GPL-2"
IUSE="cdparanoia"

DEPEND=">=media-video/vdr-2.1.10
	dev-libs/xerces-c
	dev-libs/libcec"

src_prepare() {
	vdr-plugin-2_src_prepare
	
	sed -i "s:/video/conf:/usr/share/vdr:" contrib/cecremote.xml || die "failed to adapt resources path"

	mkdir po
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins contrib/cecremote.xml
	fowners -R vdr:vdr /etc/vdr/plugins/${VDRPLUGIN}

	insinto /usr/share/vdr/plugins//${VDRPLUGIN}
	doins contrib/blueray.mpg
}
