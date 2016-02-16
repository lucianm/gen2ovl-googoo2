# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

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

DESCRIPTION="Video Disk Recorder - \"TvGuideNG\" - hightly customizable 2D EPG viewer plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-libs/libskindesignerapi-0.1.0
	>=media-plugins/vdr-skindesigner-0.4.0"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin-2_src_install
	chown vdr:vdr -R "${D}"/etc/vdr
}

#pkg_postinst() {
#	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
#	einfo "especially for the channel logos path, and in general, make sure"
#	einfo "they end with an \"/\""
#}
