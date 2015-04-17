# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Scan for channels on DVB-? and on PVR*-Cards"
HOMEPAGE="http://wirbel.htpc-forum.de/wirbelscan/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/wirbelscancontrol/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr
	>=media-plugins/vdr-wirbelscan-0.0.9"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	rm wirbelscan_services.h
	ln -s /usr/include/wirbelscan_services.h wirbelscan_services.h
}
