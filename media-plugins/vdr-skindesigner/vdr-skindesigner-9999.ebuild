# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font vdr-plugin-2


if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	SRC_URI="http://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git/snapshot/vdr-plugin-${VDRPLUGIN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi

DESCRIPTION="Video Disk Recorder - \"${VDRPLUGIN}\" - modern text2skin-like engine to display XML based skins"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2 Apache-2.0"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/VDROpenSans"

DEPEND=">=media-libs/libskindesignerapi-0.0.2
	dev-libs/libxml2
	gnome-base/librsvg
	virtual/jpeg
	x11-libs/cairo[svg]
	media-plugins/vdr-epgsearch"

	
RDEPEND="${DEPEND}
	virtual/channel-logos-hq"

PATCHES="${FILESDIR}/${PN}_no-subproject-when-separate-package.patch"

SKINDESIGNER_CACHEDIR="/var/cache/vdr/plugins/${VDRPLUGIN}"

src_prepare() {
	vdr-plugin-2_src_prepare

	# adjust plugin cache ND SCRIPT directories:
	chmod -R ugo+x ${S}/scripts/temperatures*	
	for script in config.h $(ls ${S}/scripts/temperatures*); do
		sed -i "s:/tmp/${VDRPLUGIN}:${SKINDESIGNER_CACHEDIR}:" $script || die
	done
	BUILD_PARAMS+=" PREFIX=/usr SKINDESIGNER_SCRIPTDIR=/etc/vdr/plugins/${VDRPLUGIN}/scripts"
}

pkg_setup() {
	vdr-plugin-2_pkg_setup
	font_pkg_setup
}

src_install() {
	vdr-plugin-2_src_install
	font_src_install
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst
	font_pkg_postinst

	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
	einfo "especially for the channel logos path, and in general, make sure"
	einfo "they end with an \"/\""
	einfo ""
	einfo "Please also check /etc/vdr/plugins/${VDRPLUGIN}/scripts/README !!!"
	
	elog "To properly use the skins provided by \"skindesigner\", please follow the most important hints from the README:\n"

	elog "For S2-6400 Users: Disable High Level OSD, otherwise the plugin will not be"
	elog "loaded because lack of true color support\n"

	elog "For Xine-Plugin Users: Set \"Blend scaled Auto\" as OSD display mode to achieve"
	elog "an suitable true color OSD.\n"

	elog "For Xineliboutput Users: Start vdr-sxfe with the --hud option enabled\n"

	elog "If you want \"skindesigner\" to use Channel Logos, please read the \"Channel Logos\" section in the README file.\n"
}

pkg_postrm() {
	vdr-plugin-2_pkg_postrm
	font_pkg_postrm
}
