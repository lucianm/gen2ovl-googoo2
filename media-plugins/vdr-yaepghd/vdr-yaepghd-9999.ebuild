# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vdr-plugin-2 git-2

DESCRIPTION="yaepghd plugin for nice epg"
HOMEPAGE="https://github.com/lucianm/vdr-plugin-yaepghd"
#HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-yaepghd"
SRC_URI=""
EGIT_REPO_URI="git://github.com/lucianm/vdr-plugin-yaepghd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-video/vdr-1.7.33
	media-gfx/imagemagick"
DEPEND="${RDEPEND}"

src_install() {
	vdr-plugin-2_src_install

	dodir /etc/vdr/plugins || die
	insinto /etc/vdr/plugins
	doins -r yaepghd || die
	fowners -R vdr:vdr /etc/vdr || die
}
