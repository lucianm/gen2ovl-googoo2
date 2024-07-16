# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Scan for channels on DVB-? and on PVR*-Cards"
HOMEPAGE="http://www.gen2vdr.de/wirbel/wirbelscan/index2.html"


case "${PV}" in
	9999)
		SRC_URI=""
		KEYWORDS=""
		S="${WORKDIR}/${P}"

		EGIT_REPO_URI="https://github.com/wirbel-at-vdr-portal/${VDRPLUGIN}-dev.git"
		inherit git-r3
		;;
	*)
		SRC_URI="https://github.com/wirbel-at-vdr-portal/${VDRPLUGIN}-dev/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="amd64 ~arm ~arm64 ~ppc x86"
		S="${WORKDIR}/${VDRPLUGIN}-dev-${PV}"
		;;
esac


LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-2.4.1
	dev-libs/librepfunc
	!<media-tv/ivtv-0.8"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include scanfilter.cpp si_ext.h
	eapply_user
}

src_install() {
	vdr-plugin-2_src_install
	
	doheader wirbelscan_services.h
}
