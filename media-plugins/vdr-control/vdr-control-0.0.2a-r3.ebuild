# Copyright 2003-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=7

IUSE=""
inherit vdr-plugin-2 eutils

#RESTRICT="mirror"

MY_PV="${PV}-kw3"

DESCRIPTION="Video Disk Recorder telnet-OSD PlugIn"
HOMEPAGE="http://www.u32.de//vdr.html"
SRC_URI="http://www.u32.de/download/${PN}-${MY_PV}.tar.gz
		mirror://vdrfiles/${PN}/${PN}-${MY_PV}.tar.gz"

S="${WORKDIR}/${VDRPLUGIN}-${MY_PV}"

KEYWORDS="~x86 ~amd64 ~arm"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-2.2.0"

PATCHES=("${FILESDIR}/${P}_gcc44.diff"
	"${FILESDIR}/${P}-kw3.diff"
	"${FILESDIR}/${P}-kw3_vdrsocket.diff")
#	"${FILESDIR}/control-vdr-1.3.18.diff"
#"${FILESDIR}/${P}-uint64.diff"
