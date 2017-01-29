# Copyright 2017 Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/M-Reimer/script.service.graphlcd.git"
EGIT_BRANCH="master"

inherit git-r3 eutils

DESCRIPTION="GraphLCD addon for Kodi"
HOMEPAGE="https://github.com/M-Reimer/script.service.graphlcd"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-tv/kodi
	>=app-misc/graphlcd-base-9999
	"

src_prepare() {
	sed -i "s:python2):python-2.7):" Makefile || die "Failed to patch Makefile for Python 2.7"
}
