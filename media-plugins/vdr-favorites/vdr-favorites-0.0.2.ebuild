# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: implements a favourites channels menu"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Favorites-plugin"
SRC_URI=""
#${P}.tgz"
KEYWORDS="~x86 ~amd64 ~arm"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

RESTRICT="mirror"

DEPEND=">=media-video/vdr-1.7.8"

RDEPEND="${DEPEND}"

src_unpack() {
	cd "${DISTDIR}"
	wget --content-disposition 'http://www.vdr-portal.de/index.php?page=Attachment&attachmentID=29502&h=94727dd6a26dae63371fe764e69f413bc82339ba'
	cd "${WORKDIR}"

	unpack "${P}.tgz"
}
