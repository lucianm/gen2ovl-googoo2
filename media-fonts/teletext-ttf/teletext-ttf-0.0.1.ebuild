# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit font

DESCRIPTION="TTF Font usable for teletext"

HOMEPAGE="https://github.com/xbmc/xbmc"
SRC_URI="https://github.com/xbmc/xbmc/raw/d3a7f95f3f017b8e861d5d95cc4b33eef4286ce2/media/Fonts/teletext.ttf"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

FONT_SUFFIX="ttf"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${A}" "${S}"
}

pkg_postinst() {
	font_pkg_postinst
}
