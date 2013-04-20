# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xine/vdr-xine-0.9.4-r1.ebuild,v 1.1 2013/01/27 16:57:24 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: for 'software only' playback using xine"
HOMEPAGE="http://home.vr-web.de/~rnissl/"
SRC_URI="http://home.vr-web.de/~rnissl/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP=">=media-video/vdr-1.7.33
	>=media-libs/xine-lib-1.1.8[vdr]"
DEPEND="${COMMON_DEP}"
RDEPEND="${COMMON_DEP}
	media-video/mjpegtools
	media-libs/netpbm
	media-video/y4mscaler"

src_prepare() {
	epatch "${FILESDIR}/${P}-r3-gentoo.diff"
	epatch "${FILESDIR}/${P}-build-system.patch"
	epatch "${FILESDIR}/${P}-grab.patch"
	epatch "${FILESDIR}/${P}_scaling-without-YAEPG-vdr.1.7.33_v2.patch"

	vdr-plugin-2_src_prepare

	if has_version ">=media-video/vdr-1.7.33"; then
		sed -e "s:pid == patPmtParser.PmtPid():patPmtParser.IsPmtPid(pid):" \
			-i xineDevice.c
	fi

	# remove i18n crap
	sed -e "s:^#include[[:space:]]*\"xineI18n.h\"::" -i xine.c

	BUILD_PARAMS="VDR_XINE_FIFO_DIR=/var/vdr/xine"
}

src_install() {
	vdr-plugin-2_src_install

	dobin xineplayer || die

	insinto /usr/share/vdr/plugins/xine
	doins data/* || die

	dodoc MANUAL
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	if [[ -d ${ROOT}/etc/vdr/plugins/xine ]]; then
		ewarn "You have a leftover directory of vdr-xine."
		ewarn "You can safely remove it with:"
		ewarn "# rm -rf /etc/vdr/plugins/xine"
	fi
}
