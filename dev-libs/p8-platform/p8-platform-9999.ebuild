# Copyright 2016 Daniel 'herrnst' Scheller, Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

MY_PN="platform"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/Pulse-Eight/${MY_PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/Pulse-Eight/${MY_PN}/archive/${P}.tar.gz"
	KEYWORDS="~arm ~amd64 ~x86"
	S="${WORKDIR}/${MY_PN}-${P}"
fi

DESCRIPTION="Platform support library used by libCEC and binary add-ons for Kodi."
HOMEPAGE="https://github.com/Pulse-Eight/platform"


LICENSE="GPL-2+"
SLOT="0"

IUSE=""

RDEPEND="!dev-libs/libplatform"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=1
	)
	cmake-utils_src_configure
}
