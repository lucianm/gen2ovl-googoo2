# Copyright 2003-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

IUSE=""
inherit vdr-plugin-2 eutils

#RESTRICT="mirror"

DESCRIPTION="Video Disk Recorder telnet-OSD PlugIn"
HOMEPAGE="http://ricomp.de/vdr/"
SRC_URI="http://ricomp.de/vdr/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

PATCHES="${FILESDIR}/${P}-uint64.diff
	${FILESDIR}/${P}_gcc44.diff"

src_prepare() {
	vdr-plugin-2_src_prepare
	if has_version ">=media-video/vdr-1.3.18"; then
		einfo "applying VDR >= 1.3.18 patch"
		epatch "${FILESDIR}/control-vdr-1.3.18.diff"
	fi
}
