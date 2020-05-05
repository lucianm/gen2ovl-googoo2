# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit channel-logos git-r3

HOMEPAGE="https://www.picons.eu"
SRC_URI=""
EGIT_REPO_URI="https://github.com/picons/picons.git"
#EGIT_PROJECT="${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

S="${WORKDIR}/${P}"

RRDEPEND="${DEPEND}"

src_compile() {
	# TODO: analyze how its being done for vdr/kodi, set dependencies, copy channels.conf, etc...
	die "This is still WIP, it does not work yet, sorry !!!"
	1-build-servicelist.sh
	2-build-picons.sh
}

src_install() {
	dodoc README.md
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	doins -r backgrounds radio tv *.srindex
}
