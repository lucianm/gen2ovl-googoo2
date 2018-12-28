# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: blocks EPG storage starting from a set border channel number"
HOMEPAGE="https://github.com^/M-Reimer/vdr-plugin-${VDRPLUGIN}"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/M-Reimer/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
	S=${WORKDIR}/${P}
	inherit git-r3
else
	SRC_URI="https://github.com/M-Reimer/vdr-plugin-${VDRPLUGIN}/archive/${PV}.tar.gz -> vdr-${VDRPLUGIN}-${PV}.tar.gz"
	KEYWORDS="~arm ~amd64 ~x86"
	S=${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=media-video/vdr-2.2.0"
RDEPEND="${DEPEND}"
