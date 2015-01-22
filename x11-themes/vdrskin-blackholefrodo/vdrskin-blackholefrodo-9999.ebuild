# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

SKIN_NAME="${PN/vdrskin-/}"
#SKIN_NAME="Vectra"

DESCRIPTION="VDR skindesigner: ${SKIN_NAME}"
HOMEPAGE="https://github.com/FrodoVDR/blackholefrodo"
EGIT_REPO_URI="https://github.com/FrodoVDR/blackholefrodo.git"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-plugins/vdr-skindesigner"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /usr/share/vdr/plugins/skindesigner/skins/${SKIN_NAME}
	doins -r themes
	doins -r xmlfiles
	doins setup.xml
	insinto /etc/vdr/themes
	doins vdr-themes/*
	dodoc README*
}
