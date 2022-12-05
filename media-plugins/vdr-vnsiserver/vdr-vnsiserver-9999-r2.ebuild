# Copyright 2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

inherit vdr-plugin-2

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lucianm/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://github.com/lucianm/vdr-plugin-${VDRPLUGIN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi


DESCRIPTION="VDR plugin: VNSI Streamserver Plugin"
HOMEPAGE="https://github.com/lucianm/vdr-plugin-${VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-2.2.0
	sys-libs/zlib"

RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include videoinput.c
	fix_vdr_libsi_include demuxer.c
	
	if has_version ">=media-plugins/vdr-wirbelscan-0.0.9"; then
		rm wirbelscan_services.h
		ln -s /usr/include/wirbelscan_services.h wirbelscan_services.h
	fi
	eapply_user
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${VDRPLUGIN}/allowed_hosts.conf
	diropts -gvdr -ovdr
}
