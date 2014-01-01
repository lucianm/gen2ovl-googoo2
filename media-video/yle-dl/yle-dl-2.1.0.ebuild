# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="CLI tool for downloading media from finnish VoD services Yle Areena, Elävä Arkisto & YleX Areena"
HOMEPAGE="http://aajanki.github.io/yle-dl/index.html"
MY_PN="aajanki-${PN}"
VER_HASH="51f30c8"
SRC_URI="https://github.com/aajanki/yle-dl/tarball/${PV}/${MY_PN}-${PV}-0-g${VER_HASH}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=media-video/rtmpdump-2.4
	dev-python/pycrypto"

S="${WORKDIR}/${MY_PN}-${VER_HASH}"

src_prepare() {

	sed -i "s:prefix=:prefix?=:" Makefile || die "Failed to sed prefix in makefile"

}

src_install() {

	einstall DESTDIR="${D}" prefix="/usr"
	dodoc README* ChangeLog

}
