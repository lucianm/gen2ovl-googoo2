# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit channel-logos git-2

HOMEPAGE="https://bitbucket.org/picons/logos"
SRC_URI=""
EGIT_REPO_URI="https://bitbucket.org/picons/logos.git"
EGIT_PROJECT="${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

S=${WORKDIR}

RRDEPEND="${DEPEND}"

src_install() {
	dodoc README.md
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	doins -r backgrounds radio tv *.srindex
}
