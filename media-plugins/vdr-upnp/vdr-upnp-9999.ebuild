# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin eutils git-2

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

PATCHES="${FILESDIR}/${P}_Makefile-plugins.diff"

#src_prepare() {

#	vdr-plugin_src_prepare

#}

src_compile() {

	cd "${S}"
	LIBDIR="${S}" LOCALEDIR="${TMP_LOCALE_DIR}" TMPDIR="${T}" make || die "compilation failed..."

}

src_install() {

	vdr-plugin_src_install

	insinto "${VDR_PLUGIN_DIR}"
	doins libupnp-*.so.*

	insinto "/etc/vdr/plugins/${VDRPLUGIN}"
	doins -r httpdocs

}
