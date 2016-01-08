# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit eutils

DESCRIPTION="VDR Config Manager - interactive console dialogs script for managing VDR configuration files"
HOMEPAGE="https://github.com/lucianm/${PN}"

case "${PV}" in
	9999)
		EGIT_REPO_URI="${HOMEPAGE}.git"
		inherit git-r3
		KEYWORDS=""
		;;
	*)
		SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~x86 ~arm"
		;;
esac

SLOT="0"
LICENSE="GPL-2"

RDEPEND="sys-apps/coreutils
	sys-apps/which
	sys-apps/util-linux
	sys-apps/grep
	|| (	dev-libs/newt
		dev-util/dialog )"

DEPEND="${RDEPEND}
	virtual/pkgconfig" # pkg-config is actually a runtime dependency, but repoman does not like that

IUSE=""

src_prepare() {
	if [ "${PV}" == "9999" ]; then
		sed -i "s:-f2):-f2).9999:" Makefile || die "Could not adjust the version in the Makefile"
	fi
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" NO_LICENSE_INST="1" install
}

pkg_postinst() {
	elog "It actually makes sense to use '${PN}' only if >=vdr-2.2.0 is emerged,"
	elog "yet vdr is not a dependency, as only the config direcrtories ARGSDIR and"
	elog "on the same directory hierarchic level, 'conf.avail' are required for '${PN}'"
	elog ""
	elog "Nevertheless, in order to find them out, eiter >=vdr-2.2.0 should be emerged,"
	elog "or the file '~/.${PN}' containing the path to the ARGSDIR should exist, please"
	elog "have a look in the README.md file for details"
}
