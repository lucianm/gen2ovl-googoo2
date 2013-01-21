# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 git-2

EGIT_REPO_URI="git://github.com/pipelka/vdr-plugin-xvdr.git"

DESCRIPTION="VDR plugin: XVDR Streamserver Plugin"
HOMEPAGE="https://github.com/pipelka/vdr-plugin-xvdr"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-plugin

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include src/live/livepatfilter.h
}

src_compile() {
	vdr-plugin-2_src_compile
	emake -C tools
}

src_install() {
	vdr-plugin-2_src_install
	dobin tools/serviceref

	insinto /etc/vdr/plugins/xvdr
	doins xvdr/allowed_hosts.conf
	diropts -gvdr -ovdr
}
