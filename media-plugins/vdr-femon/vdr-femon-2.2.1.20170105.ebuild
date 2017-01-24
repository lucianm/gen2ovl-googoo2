# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: DVB Frontend Status Monitor (signal strengt/noise)"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"

# SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/${P}.tgz"
SHA="ba767e02bfd15902b97cbff76d17fd365feb3c6f"
SRC_URI="https://github.com/rofafor/vdr-plugin-femon/archive/${SHA}.zip -> ${P}.zip"
S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${SHA}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=media-video/vdr-2.2.0"
RDEPEND="${DEPEND}"
