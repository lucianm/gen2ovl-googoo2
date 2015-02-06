# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils
# git-2

SKIN_NAME="${PN/vdrskin-/}"

DESCRIPTION="VDR skindesigner: ${SKIN_NAME}"
HOMEPAGE="http://www.anthra.de/shady-skin"
#EGIT_REPO_URI="https://github.com/Vectra130/skindesigner_vectraskin.git"
SRC_URI="http://www.anthra.de/shady/shady-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-plugins/vdr-skindesigner
	media-fonts/vdropensans-ttf"

S="${WORKDIR}/${SKIN_NAME}"

src_install() {
	SKIN_DIR="/usr/share/vdr/plugins/skindesigner/skins/${SKIN_NAME}"
	insinto ${SKIN_DIR}
	doins -r themes
	doins -r xmlfiles
	doins -r skinparts
	doins globals.xml
	doins setup.xml
	insinto /etc/vdr/themes
	for themename in $(ls themes); do
		themefile="themes/${themename}/${SKIN_NAME}-${themename}.theme"
		doins ${themefile}
		rm ${D}${SKIN_DIR}/${themefile}
	done
	dodoc README*
	dodoc HISTORY
}
