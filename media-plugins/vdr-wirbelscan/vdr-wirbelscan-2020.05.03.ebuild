# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=7

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Scan for channels on DVB-? and on PVR*-Cards"
HOMEPAGE="http://www.gen2vdr.de/wirbel/wirbelscan/index2.html"
SRC_URI="http://www.gen2vdr.de/wirbel/wirbelscan/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND=">=media-video/vdr-2.4.1
	!<media-tv/ivtv-0.8"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include scanfilter.h
	fix_vdr_libsi_include scanfilter.c
#	fix_vdr_libsi_include caDescriptor.h
	fix_vdr_libsi_include si_ext.h
	eapply_user
}

src_install() {
	vdr-plugin-2_src_install
	
	doheader wirbelscan_services.h
}
