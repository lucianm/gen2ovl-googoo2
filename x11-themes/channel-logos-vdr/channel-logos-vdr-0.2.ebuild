# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit channel-logos

MY_P="logos-${PV}"

HOMEPAGE="http://www.vdrskins.org/"
SRC_URI="http://www.vdrskins.org/vdrskins/albums/userpics/10138/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S=${WORKDIR}/logos

RRDEPEND="${DEPEND}
	!x11-themes/vdr-channel-logos"

src_install() {
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	find -maxdepth 1 -name "*.xpm" -print0|xargs -0 cp -a --target="${D}${CHANLOGOBASE}/${LOGOPACKNAME}/"
}
