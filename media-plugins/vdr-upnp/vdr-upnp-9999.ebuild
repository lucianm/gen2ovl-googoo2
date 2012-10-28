# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2 git-2

#VERSION="1065" #every bump, new version


DESCRIPTION="Video Disk Recorder - UPnP/DLNA support Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${VDRPLUGIN}"
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
S="${WORKDIR}/${VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=media-video/vdr-1.7.27
	>=dev-libs/tntdb-1.2
	>=dev-libs/tntnet-2.0[sdk]
	>=dev-libs/cxxtools-2.0
	>=net-libs/libupnp-1.6.14
	dev-libs/boost"

RDEPEND="${DEPEND}"

PDEPEND="=media-plugins/${PN}-subplugins-${PV}"

PATCHES="${FILESDIR}/${P}_Makefile-plugins.diff
	${FILESDIR}/${P}_cli-help.diff"

#src_prepare() {

#	vdr-plugin-2_src_prepare

#}

src_compile() {

	VDRDIR="${VDR_INCLUDE_DIR}" \
		VDRINCDIR="${VDR_INCLUDE_DIR%/vdr}" \
		vdr-plugin-2_src_compile

}

src_install() {

	vdr-plugin-2_src_install

	insinto "/etc/vdr/plugins/${VDRPLUGIN}"
	doins -r httpdocs

}
