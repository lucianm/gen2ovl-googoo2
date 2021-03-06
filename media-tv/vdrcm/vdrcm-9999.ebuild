# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=7

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

PDEPEND=">=media-video/vdr-2.2.0"

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
		sed -i "s:^script_ver=:script_ver=${PV}.:" ${PN} || die "Could not adjust the version in the ${PN} script"
		sed -i "s:\$(VERSION):${PV}:" Makefile || die "Could not adjust the version in the Makefile"
	fi
	eapply_user
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" NO_LICENSE_INST="1" install
}
