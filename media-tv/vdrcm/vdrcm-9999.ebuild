# Copyright 2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

DESCRIPTION="VDR Config Manager - interactive console dialogs script for managing VDR configuration files"
HOMEPAGE="https://github.com/lucianm/${PN}"

case "${PV}" in
	9999)
		SRC_URI=""
		KEYWORDS=""
		S="${WORKDIR}/${P}"

		EGIT_REPO_URI="${HOMEPAGE}.git"
		inherit git-r3
		;;
	*)
		SRC_URI="${HOMEPAGE}/archive/refs/tags/${P}.tar.gz"
		KEYWORDS="amd64 x86 ~arm ~arm64"
		S="${WORKDIR}/${PN}-${P}"
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
