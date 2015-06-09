# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2 autotools multilib cmake-utils

EGIT_REPO_URI="git://github.com/xbmc/kodi-platform.git"

DESCRIPTION="Kodi Platform Support Library"
HOMEPAGE="https://github.com/xbmc/kodi-platform"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=media-tv/kodi-15.0
	dev-libs/tinyxml
	dev-libs/platform"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch_user

	cmake-utils_prepare
}
