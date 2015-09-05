# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 eutils

DESCRIPTION="VDR-plugin : Offers a RESTful-API to retrieve data from VDR"
HOMEPAGE="https://github.com/yavdr/vdr-plugin-${VDRPLUGIN}"
if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/yavdr/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/yavdr/vdr-plugin-${VDRPLUGIN}/releases/download/${PV}/vdr-plugin-${VDRPLUGIN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi

SLOT="0"
LICENSE="GPL-2"
IUSE="+imagemagick"

DEPEND=">=media-video/vdr-2.1.10
	imagemagick? ( media-gfx/imagemagick )
	dev-libs/cxxtools"

src_prepare() {
	vdr-plugin-2_src_prepare
	
	use imagemagick || sed -i "s:USE_LIBMAGICKPLUSPLUS ?= 1:USE_LIBMAGICKPLUSPLUS ?= 0:" Makefile || die "failed to disable USE_LIBMAGICKPLUSPLUS"

	sed -i "s:\$(DESTDIR)\$(PLGCONFDIR):\$(DESTDIR)usr/share/vdr/plugins/${VDRPLUGIN}:" Makefile || die "failed to adapt resources path"
}

src_install() {
	dodir /usr/share/vdr/plugins/${VDRPLUGIN}

	vdr-plugin-2_src_install
	
	dodoc INSTALL
	
	insinto /usr/share/vdr/plugins/${VDRPLUGIN}
	doins -r web/*
	
	fperms -R ugo-x /usr/share/vdr/plugins/${VDRPLUGIN}
}
