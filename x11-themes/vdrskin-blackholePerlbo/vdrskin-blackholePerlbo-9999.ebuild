# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils
# git-2

SKIN_NAME="${PN/vdrskin-/}"
#SKIN_NAME="Vectra"

DESCRIPTION="VDR skindesigner: ${SKIN_NAME}"
HOMEPAGE="https://github.com/louisbraun/${SKIN_NAME}"
#EGIT_REPO_URI="https://github.com/louisbraun/${SKIN_NAME}.git"
SRC_URI="https://dl.dropboxusercontent.com/u/75246204/blackholePerlbo13-03.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-plugins/vdr-skindesigner"

S="${WORKDIR}/${SKIN_NAME}"

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
		if [ -f "${themefile}" ]; then
			rm ${D}${SKIN_DIR}/${themefile}
		else
			echo "Description = ${themename}" > "${themefile}"
		fi
		doins "${themefile}"
	done
}
