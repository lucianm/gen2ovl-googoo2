# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8


DESCRIPTION="Scan DVB-C/DVB-T(2)/DVB-S(2)/ATSC(VSB & QAM)/SAT>IP cahnnels, successor of legacy w_scan"
HOMEPAGE="http://www.gen2vdr.de/wirbel/${PN}/index2.html"


case "${PV}" in
	99999999)
		SRC_URI=""
		V_VDR="2.6.9"
		V_SATIP="20240224" # not working with upstream vdr-satip, as wirbel needed to fork his own version
		V_WIRBELSCAN="2023.10.15"
		KEYWORDS=""

		EGIT_REPO_URI="https://github.com/wirbel-at-vdr-portal/${PN}.git"
		inherit git-r3
		;;
	*)
		SRC_URI="https://github.com/wirbel-at-vdr-portal/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
		V_VDR="2.6.9"
		V_SATIP="20240224" # not working with upstream vdr-satip, as wirbel needed to fork his own version
		V_WIRBELSCAN="2023.10.15"
		KEYWORDS="amd64 ~arm ~arm64 ~ppc x86"
		;;
esac

# this program needs 3 more additional source archives at build time, therefore we cannot use the respective installed packages
# as the program links against object code from those sources unavailable as installed libraries...

SRC_URI="${SRC_URI}
	http://git.tvdr.de/?p=vdr.git;a=snapshot;h=refs/tags/${V_VDR};sf=tbz2 -> vdr-${V_VDR}.tbz2
	https://github.com/wirbel-at-vdr-portal/wirbelscan-dev/archive/refs/tags/${V_WIRBELSCAN}.tar.gz -> vdr-wirbelscan-${V_WIRBELSCAN}.tar.gz"
SRC_URI="${SRC_URI}
	https://github.com/wirbel-at-vdr-portal/vdr-plugin-satip/archive/refs/tags/${V_SATIP}.tar.gz -> vdr-satip-wirbel_fork-${V_SATIP}.tar.gz"

S="${WORKDIR}/${P}"
MY_PV="${PV}"


LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=sys-libs/glibc-2.12
	media-libs/libjpeg-turbo
	sys-libs/libcap
	virtual/os-headers
	sys-devel/gettext
	media-libs/freetype
	media-libs/fontconfig
	dev-libs/pugixml
	dev-libs/librepfunc
	>=net-misc/curl-7.36"

RDEPEND="${DEPEND}"
BDEPEND=">=sys-devel/gcc-4.9"

src_unpack() {
	unpack ${A}
	if [[ "${PV}" == "99999999" ]]; then
		git-r3_src_unpack
		MY_PV="git:$(date +%Y%m%d).${EGIT_VERSION}"
	fi
}

src_prepare() {
	ln -s ${WORKDIR}/vdr-${V_VDR} ${S}/vdr || die
	ln -s ${WORKDIR}/vdr-plugin-satip-${V_SATIP} ${S}/vdr/PLUGINS/src/satip || die
	ln -s ${WORKDIR}/wirbelscan-dev-${V_WIRBELSCAN} ${S}/vdr/PLUGINS/src/wirbelscan || die

	eapply "${FILESDIR}/w_scan_cpp-${PV}_build-vdr-fix.diff" || die
	eapply "${FILESDIR}/w_scan_cpp-makefile_vars_linuxFHS.diff" || die
	rm ${S}/vdr/vdr.c || die

	eapply_user
}

src_compile() {
	if [[ "${PV}" == "99999999" ]]; then
		emake VERSION="${MY_PV}" version
	fi
	emake
}

src_install() {
	emake PKG_VERSION="-${PV}" DESTDIR="${D}" prefix="/usr" install
}
