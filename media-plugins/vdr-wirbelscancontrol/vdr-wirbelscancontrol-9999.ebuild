# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Extending vdr-wirbelscan with a main menu entry"
HOMEPAGE="http://www.gen2vdr.de/wirbel/wirbelscancontrol/index2.html"


case "${PV}" in
	9999)
		SRC_URI=""
		KEYWORDS=""
		S="${WORKDIR}/${P}"

		EGIT_REPO_URI="https://github.com/wirbel-at-vdr-portal/${VDRPLUGIN}.git"
		inherit git-r3
		;;
	*)
		SRC_URI="https://github.com/wirbel-at-vdr-portal/${VDRPLUGIN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="amd64 ~arm ~arm64 ~ppc x86"
		S="${WORKDIR}/${VDRPLUGIN}-${PV}"
		;;
esac


LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-plugins/vdr-wirbelscan-2021.10.09"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	rm wirbelscan_services.h
	ln -s /usr/include/wirbelscan_services.h wirbelscan_services.h
	eapply_user
}
