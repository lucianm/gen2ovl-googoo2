# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

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
	einfo "Please download the attachment 'http://www.vdr-portal.de/index.php?page=Attachment&attachmentID=29502&h=94727dd6a26dae63371fe764e69f413bc82339ba'"
	einfo "from 'http://www.vdr-portal.de/board1-news/board101-news-archiv/p1039565-announce-vdr-favorites-0-0-2/#post1039565'"
	einfo "with a web browser and place them in ${DISTDIR} renamed"
	einfo "EXACTLY as ${SRC_URI} !!!"
}
