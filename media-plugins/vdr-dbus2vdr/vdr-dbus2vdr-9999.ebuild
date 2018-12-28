# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=7

inherit vdr-plugin-2 systemd

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/flensrocker/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
	S=${WORKDIR}/${P}
	inherit git-r3
else
	SRC_URI="https://github.com/flensrocker/vdr-plugin-${VDRPLUGIN}/releases/download/v${PV}/vdr-${VDRPLUGIN}-${PV}.tgz"
	KEYWORDS="~arm ~amd64 ~x86"
	S=${WORKDIR}/${VDRPLUGIN}-${PV}
fi

DESCRIPTION="VDR plugin: control VDR via DBus (including SVDRP replacement for plugin commands)"
HOMEPAGE="https://github.com/flensrocker/vdr-plugin-${VDRPLUGIN}"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=">=media-video/vdr-1.7.8
	sys-apps/dbus
	virtual/jpeg
	dev-libs/glib
	dev-cpp/pngpp"

RDEPEND="${DEPEND}"

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
