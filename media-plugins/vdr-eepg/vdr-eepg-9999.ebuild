# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: parses extended (2 to 10 day) EPG data which is send by providers on their
		portal channels in a non-standard format on a non-standard PID"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"
if [[ "${PV}" = "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
	EEPG_GIT_BRANCH="experimental"
	: ${EGIT_REPO_URI:=${EEPG_GIT_REPO_URI:-git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git}}
	: ${EGIT_BRANCH:=${EEPG_GIT_BRANCH:-master}}
	inherit git-2
	S="${WORKDIR}/${VDRPLUGIN}"
else
	MY_PV="${PV/_/}"
	SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.gz
		http://vdr.websitec.de/download/${PN}/${PN}-${MY_PV}.tar.gz
		http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}/files/${PN}-${MY_PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${VDRPLUGIN}-${MY_PV}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=">=media-video/vdr-1.7.14"

RDEPEND="${DEPEND}"

#PATCHES="${FILESDIR}/${P}-experimental_libsi-includes.diff"

src_prepare() {
	vdr-plugin-2_src_prepare
	fix_vdr_libsi_include dish.c dish.h eepg.c eit2.h epghandler.c
	if use debug; then
		sed -i Makefile -e 's@-O1@@' || die "Failed to remove compile flags from Makefile"
	fi
}

src_install() {
	vdr-plugin-2_src_install
	dodoc TODO
	newdoc scripts/README README.scripts
	dobin scripts/*.sh
	dobin scripts/*.pl
	insinto "/etc/vdr/plugins/${VDRPLUGIN}"
	doins ${VDRPLUGIN}.equiv*
}
