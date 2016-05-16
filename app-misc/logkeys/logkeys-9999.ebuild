# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A GNU/Linux keylogger that works!"
HOMEPAGE="https://github.com/kernc/${PN}"

if [ "${PV}" = "9999" ]; then
	inherit git-r3 autotools-utils
	EGIT_REPO_URI="https://github.com/kernc/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/kernc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RESTRICT="nomirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	if [ "${PV}" = "9999" ]; then
		eautoreconf || die
	fi
}
