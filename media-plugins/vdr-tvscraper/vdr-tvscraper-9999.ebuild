# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder PlugIn which collects metadata for EPG events in the background"
HOMEPAGE="https://github.com/MarkusEh/vdr-plugin-${VDRPLUGIN}"

case "${PV}" in
	9999)
		SRC_URI=""
		KEYWORDS=""
		S="${WORKDIR}/${P}"

		EGIT_REPO_URI="${HOMEPAGE}.git"
		inherit git-r3
		;;
	*)
		SRC_URI="${HOMEPAGE}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="amd64 arm arm64 ppc x86"
		S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
		;;
esac

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-2.4.0
	>=dev-db/sqlite-3.24.0
	>=net-misc/curl-8.7.1
"

#todo:
# if using TVGuide: 1.3.6+
# if using SkinNopacity: 1.1.15+
# if using skinFlatPlus: 0.6.7+


RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/vdr-tvscraper-1.2.9_do-not-mkdir_PLGDEST.patch"

src_prepare() {
	vdr-plugin-2_src_prepare

	eapply_user
}

src_compile() {
	vdr-plugin-2_src_compile

	emake plugins || die "failed to build plugins"
}

src_install() {
	vdr-plugin-2_src_install

	DESTDIR="${D}" emake install-plugins || die "failed to install plugins"
}
