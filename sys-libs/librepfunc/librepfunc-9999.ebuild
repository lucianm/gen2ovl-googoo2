# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of functions, classes and so on, which wirbel-at-vdr-portal often uses, like in w_scan_cpp or wirbelscan"
HOMEPAGE="https://github.com/wirbel-at-vdr-portal/${PN}"

if [[ ${PV} == "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
	#S="${WORKDIR}/${P}"

	EGIT_REPO_URI="${HOMEPAGE}.git"
	inherit git-r3
else
	SRC_URI="${HOMEPAGE}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm ~arm64 ~ppc x86"
	#S="${WORKDIR}/${PN}-${P}"
fi


LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=""

src_prepare() {
	eapply ${FILESDIR}/librepfunc-makefile_vars_linuxFHS.diff
	eapply_user
}

src_install() {
	DESTDIR="${D}" VERSION="${PV}" libdirname="$(get_libdir)" emake install || die
}
