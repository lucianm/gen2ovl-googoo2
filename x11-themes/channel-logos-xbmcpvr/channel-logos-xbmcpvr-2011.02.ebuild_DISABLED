# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit channel-logos

HOMEPAGE="http://forum.xbmc.org/showthread.php?tid=86047&pid=650698"
SRC_URI="xbmcpvr_Logopack.zip
	xbmcpvr_Logopack_Update_1.zip
	xbmcpvr_Logopack_Update_2.zip
	xbmcpvr_Logopack_Update+02.2011.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="fetch"

S=${WORKDIR}

RRDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please download the attachments from ${HOMEPAGE}"
	einfo "with a web browser and place them in ${DISTDIR} renamed"
	einfo "EXACTLY in this order: ${SRC_URI} !!!"
}

src_install() {
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	cp -r -a "${S}"/* --target="${D}"${CHANLOGOBASE}/${LOGOPACKNAME}
}
