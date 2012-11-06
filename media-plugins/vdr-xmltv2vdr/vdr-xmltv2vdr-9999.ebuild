# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR importer plugin for XMLTV formatted epg data"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"
if [[ "${PV}" = "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	inherit git-2
	S="${WORKDIR}/${VDRPLUGIN}"
else
	SRC_URI="mirror://gentoo/${P}.tgz
		http://projects.vdr-developer.org/attachments/download/946/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${VDRPLUGIN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=">=media-video/vdr-1.6
	dev-libs/libxml2
	dev-libs/libzip
	dev-db/sqlite:3
	dev-libs/libpcre
	dev-libs/libzip"

RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}_epgdata2xmltv-DESTDIR.diff"

src_compile() {
	vdr-plugin-2_src_compile
	make -C dist/epgdata2xmltv || die "failed to build epgdata2xmltv"
}

src_install() {
	vdr-plugin-2_src_install
	keepdir "/etc/vdr/plugins/${VDRPLUGIN}"
	einstall DESTDIR="${D}" STRIP="" -C dist/epgdata2xmltv
}
