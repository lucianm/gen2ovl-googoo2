# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 git-2

EGIT_REPO_URI="git://github.com/FernetMenta/vdr-plugin-vnsiserver.git"

DESCRIPTION="VDR plugin: VNSI Streamserver Plugin"
HOMEPAGE="https://github.com/FernetMenta/vdr-plugin-vnsiserver"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-2.2.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include videoinput.c
	fix_vdr_libsi_include demuxer.c
	
	if has_version ">=media-plugins/vdr-wirbelscan-0.0.9"; then
		rm wirbelscan_services.h
		ln -s /usr/include/wirbelscan_services.h wirbelscan_services.h
	fi
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${VDRPLUGIN}/allowed_hosts.conf
	diropts -gvdr -ovdr
}
