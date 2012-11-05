# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: implements a favourites channels menu"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Favorites-plugin"
SRC_URI="${P}.tgz"
KEYWORDS="~x86 ~amd64 ~arm"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

RESTRICT="fetch"

DEPEND=">=media-video/vdr-1.7.8"

RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please download http://www.vdr-portal.de/index.php?page=Attachment&attachmentID=29502&h=94727dd6a26dae63371fe764e69f413bc82339ba"
	einfo "with a web browser and place it in ${DISTDIR} as ${SRC_URI} !!!"
}
