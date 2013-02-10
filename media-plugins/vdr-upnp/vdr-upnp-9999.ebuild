# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

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

PATCHES="${FILESDIR}/0001-vdr-upnp-adapted-Makefiles-to-vdr-1.7.36.patch"

src_prepare() {

	vdr-plugin-2_src_prepare
	sed -i Makefile -e "s: COPYING::"

}

src_install() {

	# install main plugin, normally
	INSDOCDIR="/usr/share/doc/${P}" \
	vdr-plugin-2_src_install

}
