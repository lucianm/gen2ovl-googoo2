# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1402" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	#SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	SRC_URI="http://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git/snapshot/vdr-plugin-${VDRPLUGIN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - \"TvGuideNG\" - hightly customizable 2D EPG viewer plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-plugins/vdr-skindesigner-0.3.0"
RDEPEND="${DEPEND}"

#VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
#VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

#PATCHES="${FILESDIR}/.."

src_install() {
	vdr-plugin-2_src_install
	chown vdr:vdr -R "${D}"/etc/vdr
}

#pkg_postinst() {
#	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
#	einfo "especially for the channel logos path, and in general, make sure"
#	einfo "they end with an \"/\""
#}
