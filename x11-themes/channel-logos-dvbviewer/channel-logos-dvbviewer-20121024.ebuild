# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit channel-logos

HOMEPAGE="http://www.dvbviewer.tv/forum/topic/21378-logopacks/"
SRC_URI="http://www.dvbviewer.tv/download/markus/Logopack/Logopack.zip
	http://www.dvbviewer.tv/download/markus/Logopack/Logopack_Update.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}

RRDEPEND="${DEPEND}"

src_install() {
	rm Thumbs.db
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	cp -r -a "${S}"/* --target="${D}"${CHANLOGOBASE}/${LOGOPACKNAME}
}
