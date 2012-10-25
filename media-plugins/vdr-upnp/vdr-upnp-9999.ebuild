# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin eutils git-2

#VERSION="1065" #every bump, new version

DVDARCHIVE="dvdarchive.sh"

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

SUBPLUGINS="plugins/profiler/vdrDVBProfiler plugins/provider/recProvider plugins/provider/vdrProvider"

src_prepare() {

	vdr-plugin_src_prepare

	for plugdir in ${SUBPLUGINS}; do
		cd "${S}/${plugdir}"
		vdr_patchmakefile
		sed -i "s:/../../lib::" Makefile
	done

}

src_install() {
	vdr-plugin_src_install

	insinto "${VDR_PLUGIN_DIR}"
	for plugdir in ${SUBPLUGINS}; do
		cd "${S}/${plugdir}"
		doins *.so.*
	done
}
