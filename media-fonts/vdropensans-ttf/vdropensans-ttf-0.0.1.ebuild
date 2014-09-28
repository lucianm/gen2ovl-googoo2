# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

S=${WORKDIR}/skindesigner-${PV}/fonts/VDROpenSans

inherit font

DESCRIPTION="TTF Font needed by the MetrixHD theme of the VDR skindesigner"

HOMEPAGE="http://projects.vdr-developer.org/projects/plg-skindesigner/repository/revisions/master/show/fonts/VDROpenSans"
SRC_URI="http://projects.vdr-developer.org/attachments/download/1803/vdr-skindesigner-${PV}.tgz"

LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~arm amd64 x86"
IUSE=""
DEPEND=""
RDEPEND=""

FONT_SUFFIX="ttf"

pkg_postinst() {
	font_pkg_postinst
}
