# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin shared library: sample PSL with fictive functionality 'XY'"
HOMEPAGE=""

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/lucianm/vdr-PSL-templates.git"
	KEYWORDS=""
else
	SRC_URI="${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.7.34"
RDEPEND="${DEPEND}"

src_unpack() {
    if [ "${PV}" = "9999" ]; then
	git-2_src_unpack
	S="${S}/${PN}"
    else
	vdr-plugin-2_src_unpack
    fi
}
