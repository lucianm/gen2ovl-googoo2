# Copyright 2015 Daniel 'herrnst' Scheller, Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/kodi-pvr/pvr.vuplus.git"
EGIT_BRANCH="master"

inherit git-r3 cmake-utils kodi-addon

DESCRIPTION="Kodi's VuPlus client addon"
HOMEPAGE="http://kodi.tv"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-tv/kodi
	media-libs/kodiplatform
	dev-libs/tinyxml
	"

RDEPEND="
	media-libs/kodiplatform
	dev-libs/tinyxml
	"
src_unpack() {
	EGIT_BRANCH="$(pvr_branch)"
	git-r3_src_unpack
}
