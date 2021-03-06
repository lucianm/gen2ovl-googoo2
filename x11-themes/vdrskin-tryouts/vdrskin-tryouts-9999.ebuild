# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

SKIN_NAME="${PN/vdrskin-/}"
#SKIN_NAME="Vectra"

DESCRIPTION="VDR skindesigner: ${SKIN_NAME}"
HOMEPAGE="https://github.com/BooStars/tryouts"
EGIT_REPO_URI="https://github.com/BooStars/tryouts.git"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-plugins/vdr-skindesigner"

S="${WORKDIR}/${PN}"

#src_prepare() {
	# do some cleanup
#	rm themes/default/menuicons/standardicons/customicons
#	rm themes/default/menuicons/standardicons/pluginicons
#	rm xmlfiles/*.save
#}

src_install() {
	SKIN_DIR="/usr/share/vdr/plugins/skindesigner/skins/${SKIN_NAME}"
	insinto ${SKIN_DIR}
	doins -r themes
	doins -r xmlfiles
	doins globals.xml
	doins setup.xml
	insinto /etc/vdr/themes
	for themename in $(ls themes); do
		themefile="themes/${themename}/${SKIN_NAME}-${themename}.theme"
		doins ${themefile}
		rm ${D}${SKIN_DIR}/${themefile}
	done
#	dodoc README*
}
