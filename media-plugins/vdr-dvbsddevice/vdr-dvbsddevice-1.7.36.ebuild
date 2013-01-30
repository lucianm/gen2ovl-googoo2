# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: output device for the 'Full Featured' DVB Card"
HOMEPAGE="http://www.tvdr.de/"
SRC_URI="ftp://ftp.tvdr.de/vdr/Developer/vdr-${PV}.tar.bz2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=media-video/vdr-${PV}"
RDEPEND="${DEPEND}"

S=${WORKDIR}/vdr-${PV}/PLUGINS/src/${VDRPLUGIN}

src_install() {
	vdr-plugin-2_src_install

	insinto /usr/include
	doins "${S}"/dvbsdffdevice.h
}
