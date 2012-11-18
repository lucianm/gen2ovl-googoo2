# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit channel-logos git-2

MY_PN="skinenigmang-logos"

HOMEPAGE="https://github.com/ocram/picons"
SRC_URI=""
EGIT_REPO_URI="git://github.com/ocram/picons.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}

RRDEPEND="${DEPEND}"

src_install() {
	dodoc README.md VERSION
	chmod ugo+x picons.sh
	./picons.sh picons
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	doins -r picons backgrounds
}
