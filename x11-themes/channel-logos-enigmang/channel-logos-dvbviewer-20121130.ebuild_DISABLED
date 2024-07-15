# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit channel-logos

MY_PN="skinenigmang-logos"

HOMEPAGE="http://andreas.vdr-developer.org/enigmang/download.html"
SRC_URI="!dxr3? ( http://andreas.vdr-developer.org/enigmang/download/${MY_PN}-xpm-hi-${PV}.tgz )
		dxr3? ( http://andreas.vdr-developer.org/enigmang/download/${MY_PN}-xpm-lo-${PV}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dxr3"

S=${WORKDIR}/skinenigmang

RRDEPEND="${DEPEND}
	!x11-themes/skinenigmang-logos"

src_install() {
	dodoc README
	rm README
	rm COPYING
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	cp -r -a "${S}"/* --target="${D}"${CHANLOGOBASE}/${LOGOPACKNAME}
}
