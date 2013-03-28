# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 git-2

EGIT_REPO_URI="${PVRADDONS_EGIT_REPO_URI:-git://github.com/opdenkamp/xbmc-pvr-addons.git}"
EGIT_PROJECT="xbmc-pvr-addons${PVRADDONS_EGIT_PROJECT:-}.git"
EGIT_BRANCH="${PVRADDONS_EGIT_BRANCH:-master}"


DESCRIPTION="VDR plugin: VNSI Streamserver Plugin"
HOMEPAGE="https://github.com/FernetMenta/xbmc-pvr-addons"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.7.22"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-plugin

src_unpack() {
	git-2_src_unpack

	S="${S}/addons/pvr.vdr.vnsi/vdr-plugin-${VDRPLUGIN}"
}

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include videoinput.c
	fix_vdr_libsi_include demuxer.c
}

src_compile() {
	vdr-plugin-2_src_compile
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${VDRPLUGIN}/allowed_hosts.conf
	diropts -gvdr -ovdr
}
