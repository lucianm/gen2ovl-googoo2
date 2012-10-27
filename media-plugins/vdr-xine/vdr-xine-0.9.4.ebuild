# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: for 'software only' playback using xine"
HOMEPAGE="http://home.vr-web.de/~rnissl/"
SRC_URI="http://home.vr-web.de/~rnissl/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug yaepg"

DEPEND=">=media-video/vdr-1.3.9
	>=media-libs/xine-lib-1.1.8[vdr]"
RDEPEND="${DEPEND}"

pkg_setup() {
	vdr-plugin-2_pkg_setup

	# we have use depend now, but better check it nevertheless :)
	if [[ -f /usr/include/xine/vdr.h ]] ; then
		einfo "detected vdr-patched xine-lib."
	else
		echo
		eerror "detected unpatched xine-lib!"
		echo
		einfo "you need to reemerge xine-lib with use-flag vdr!"
		einfo "you will find a VDR supported xine-lib ONLY on overlay vdr-testing"
		die "you need to reemerge xine-lib with use-flag vdr!"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.diff"

	use yaepg && sed -i Makefile -e "s:#VDR_XINE_SET_VIDEO_WINDOW:VDR_XINE_SET_VIDEO_WINDOW:"

	vdr-plugin-2_src_prepare
}

src_install() {
	vdr-plugin-2_src_install

	dobin xineplayer

	insinto /usr/share/vdr/xine
	doins data/*
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	if [[ -d ${ROOT}/etc/vdr/plugins/xine ]]; then
		ewarn "You have a leftover directory of vdr-xine."
		ewarn "You can safely remove it with:"
		ewarn "# rm -rf /etc/vdr/plugins/xine"
	fi
}
