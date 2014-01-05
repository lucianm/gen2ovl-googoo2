# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 git-2 systemd

EGIT_REPO_URI="${DVBAPI_EGIT_REPO_URI:-git://github.com/yavdr/vdr-plugin-${VDRPLUGIN}.git}"
EGIT_PROJECT="${PN}-plugin${DVBAPI_EGIT_PROJECT:-}.git"
EGIT_BRANCH="${DVBAPI_EGIT_BRANCH:-master}"

DESCRIPTION="VDR plugin: control VDR via DBus (including SVDRP replacement)"
HOMEPAGE="https://github.com/manio/vdr-plugin-${VDRPLUGIN}"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=">=media-video/vdr-1.7.8
	sys-apps/dbus
	virtual/jpeg
	dev-libs/glib
	dev-cpp/pngpp"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-plugin

PATCHES="${FILESDIR}/${VDRPLUGIN}-gentoo.diff"

src_prepare() {
	vdr-plugin-2_src_prepare

	# correct what patching the Makefile damages
	sed -i "s:libvdr- :libvdr-i18n.o :" Makefile || die "Failed to correct Makefile patching"	
}

src_install() {
	vdr-plugin-2_src_install

	systemd_dounit etc/${VDRPLUGIN}.service
	
	fowners -R vdr:vdr /etc/vdr/plugins/${VDRPLUGIN}
}
