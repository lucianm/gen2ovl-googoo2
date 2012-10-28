# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2 git-2

#VERSION="1065" #every bump, new version

MAIN_VDRPLUGIN=upnp

DESCRIPTION="Video Disk Recorder - Sub-plugins for the UPnP/DLNA support Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${MAIN_VDRPLUGIN}"
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${MAIN_VDRPLUGIN}.git"
S="${WORKDIR}/${MAIN_VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="=media-plugins/vdr-upnp-${PV}"

RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/vdr-${MAIN_VDRPLUGIN}-${PV}_Makefile-plugins.diff"

#src_prepare() {

#	vdr-plugin-2_src_prepare

#}

src_compile() {

	VDRDIR="${VDR_INCLUDE_DIR}" \
		VDRINCDIR="${VDR_INCLUDE_DIR%/vdr}" \
		BUILD_TARGETS="subplugins" \
		VDRPLUGINLIBDIR="${VDR_PLUGIN_DIR}" \
		ROOTBUILDDIR="${S}" \
		vdr-plugin-2_src_compile

}

src_install() {

	insinto "${VDR_PLUGIN_DIR}"
	doins lib${MAIN_VDRPLUGIN}-*.so.*

	# each subplugin has a README, they are grouped into categories ($i),
	# so let's organize them in that directory structure
	for i in $(ls -A -I ".*" "${S}/plugins"); do
		for j in $(ls -A -I ".*" "${S}/plugins/$i"); do
			cd "${S}/plugins/$i/$j"
			mkdir -p "$i"
			mv README "$i/README.$j"
			dodoc -r "$i"
		done
	done
}
