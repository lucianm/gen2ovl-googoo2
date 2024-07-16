# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder telnet-OSD PlugIn"
HOMEPAGE="https://github.com/wirbel-at-vdr-portal/vdr-plugin-${VDRPLUGIN}"

case "${PV}" in
	9999)
		SRC_URI=""
		KEYWORDS=""
		S="${WORKDIR}/${P}"

		EGIT_REPO_URI="${HOMEPAGE}.git"
		inherit git-r3
		;;
	*)
		SRC_URI="${HOMEPAGE}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="amd64 arm arm64 ppc x86"
		S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
		;;
esac

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-2.2.0"

src_prepare() {
	vdr-plugin-2_src_prepare

	eapply_user
}
