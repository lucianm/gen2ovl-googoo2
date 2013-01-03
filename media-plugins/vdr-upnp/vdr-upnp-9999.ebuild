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

RDEPEND="${DEPEND}
	>=media-plugins/vdr-streamdev-0.6.0[server,upnp]"

src_compile() {

	# build main plugin, normally
	VDRDIR="${VDR_INCLUDE_DIR}" \
		VDRINCDIR="${VDR_INCLUDE_DIR%/vdr}" \
		vdr-plugin-2_src_compile

	# build sub-plugins
	VDRDIR="${VDR_INCLUDE_DIR}" \
		VDRINCDIR="${VDR_INCLUDE_DIR%/vdr}" \
		BUILD_TARGETS="subplugins" \
		VDRPLUGINLIBDIR="${VDR_PLUGIN_DIR}" \
		ROOTBUILDDIR="${S}" \
		vdr-plugin-2_src_compile

}

src_install() {

	# install main plugin, normally
	vdr-plugin-2_src_install

	insinto "/etc/vdr/plugins/${VDRPLUGIN}"
	doins -r httpdocs

	# install sub-plugins
	insinto "${VDR_PLUGIN_DIR}"
	doins lib${VDRPLUGIN}-*.so.*

	# each subplugin has a README, they are grouped into categories ($i),
	# so let's organize them in that directory structure
	# also, install any possible *.conf files in the main plugins
	# config directory
	for i in $(ls -A -I ".*" "${S}/plugins"); do
		for j in $(ls -A -I ".*" "${S}/plugins/$i"); do
			cd "${S}/plugins/$i/$j"
			for cfg in $(ls *.conf); do
				insinto "/etc/vdr/plugins/${VDRPLUGIN}"
				doins $cfg;
			done
			docinto "$i"
			newdoc README "README.$j"
		done
	done

}
