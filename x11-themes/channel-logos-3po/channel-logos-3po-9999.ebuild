# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit channel-logos git-2

HOMEPAGE=""
SRC_URI=""
EGIT_REPO_URI="git://github.com/3PO/Senderlogos.git"
EGIT_PROJECT="${PN}.git"

LICENSE="3PO"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

S=${WORKDIR}

RRDEPEND="${DEPEND}"

src_prepare() {
	rm -f "separatorlogos/ard dritte programme.png"
	rm -f "separatorlogos/zdf vision hd.png"

	convmv --notest --replace -f cp-850 -t utf-8 -r "${S}"/
#	channel-logos_src_prepare
}

src_install() {
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	doins -r *.png Alternativlogos backgrounds l-tv nick separatorlogos
}
