# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit vdr-plugin-2 git-2

DESCRIPTION="yaepghd plugin for nice epg"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-yaepghd"
SRC_URI=""
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-yaepghd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-video/vdr-1.7.33"
DEPEND="${RDEPEND}"

PATCHES="
	${FILESDIR}/0001-yaepghd-video-scaling-without-YAEPG-vdr-1.7.33.patch
	${FILESDIR}/0002-yaepghd-add-delete-timer.patch
	${FILESDIR}/0003-yaepghd-center-text.patch
	${FILESDIR}/0004-yaepghd-anthra_1920-theme.patch
"
src_prepare() {
	epatch "${FILESDIR}/operands.patch"
	vdr-plugin-2_src_prepare
}

src_install() {
	vdr-plugin-2_src_install

	dodir /etc/vdr/plugins || die
	insinto /etc/vdr/plugins
	doins -r yaepghd || die
	fowners -R vdr:vdr /etc/vdr || die
}
