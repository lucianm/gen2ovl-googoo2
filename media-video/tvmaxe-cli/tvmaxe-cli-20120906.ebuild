# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="CLI version of tv-maxe"
HOMEPAGE="http://nknwn.github.com/tvmaxe-cli/"
SRC_URI="dl.dropbox.com/u/5635113/tvmaxe-cli-20120906.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-video/mplayer
	 net-p2p/sopcast-bin"
DEPEND=""

S="${WORKDIR}/${P}"

src_install() {
	cd "${S}"
	dobin ${PN}
	dodoc README .subscrieri
}
