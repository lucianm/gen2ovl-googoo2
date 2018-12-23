# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: DVB Frontend Status Monitor (signal strengt/noise)"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"

#SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/${P}.tgz"
#S="${WORKDIR}/${VDRPLUGIN}-${PV}"

SHA="d366856c719874ddf13886a00d741c4faa14130c"
SRC_URI="https://github.com/rofafor/vdr-plugin-femon/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${SHA}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=media-video/vdr-2.2.0"
RDEPEND="${DEPEND}"

