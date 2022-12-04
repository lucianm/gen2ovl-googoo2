# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: integrates SAT>IP network devices seamlessly into VDR"
HOMEPAGE="https://github.com/rofafor/vdr-plugin-satip"


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
		KEYWORDS="amd64 ~arm ~arm64 ~ppc x86"
		S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
		;;
esac

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="
	>=media-video/vdr-2.4.0
	>=net-misc/curl-7.36
	|| ( dev-libs/tinyxml dev-libs/pugixml )"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="
	usr/lib/vdr/plugins/libvdr-satip.*
	usr/lib64/vdr/plugins/libvdr-satip.*"

src_prepare() {
	vdr-plugin-2_src_prepare

	if has_version "dev-libs/tinyxml"; then
		sed -e "s:#SATIP_USE_TINYXML:SATIP_USE_TINYXML:" -i Makefile || die "sed failed"
	fi
}
