# Copyright 2015 Daniel 'herrnst' Scheller, Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ "${PV}" == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

EGIT_REPO_URI="https://github.com/kodi-pvr/pvr.vdr.vnsi.git"
EGIT_BRANCH="master"

inherit git-r3 cmake-utils kodi-addon

DESCRIPTION="Kodi PVR addon VNSI"
HOMEPAGE="http://kodi.tv"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"

IUSE=""

DEPEND="
	media-tv/kodi
	media-libs/kodiplatform
	virtual/opengl
	"

src_unpack() {
#	EGIT_BRANCH="$(addon_branch)"
	if [[ "${PV}" == "2.1.1" ]]; then
		EGIT_COMMIT="894555c62ff83feb7dd56e18fe199ecafabfd878"
		# PVR API: 4.2.0
	fi
	git-r3_src_unpack
}
