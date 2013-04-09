# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2

SKINNAME="${PN/xbmc-addon-skin/}"

EGIT_REPO_URI="git://github.com/liquidolze/Skin.${SKINNAME}.git"

DESCRIPTION="XBMC addon: liquidolze's 'Rise' skin, suitable for usage with vnsi / xvdr"
HOMEPAGE="https://github.com/liquidolze/Skin.${SKINNAME}"
SRC_URI=""
KEYWORDS=""
LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"
IUSE=""

RDEPEND=">=media-tv/xbmc-12.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/Skin.${SKINNAME}"

src_install() {
	insinto "/usr/share/xbmc/addons/skin.${SKINNAME}"
	for fileordir in "$(ls --group-directories-first | grep -v README | grep -v .txt)"; do
		doins -r ${fileordir}
	done
	doins changelog.txt
	dodoc README.*
	dodoc changelog.txt
}
