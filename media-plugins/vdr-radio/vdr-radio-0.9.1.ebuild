# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: show background image for radio and decode RDS Text"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=58795"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/vdr-1.7.34"
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}/${P}_vdr-1.7.34.diff"

src_install() {

	vdr-plugin-2_src_install

	cd "${S}"/config

	insinto /usr/share/vdr/plugins/radio
	doins mpegstill/rtext*
	dosym rtextOben-kleo2-live.mpg /usr/share/vdr/plugins/radio/radio.mpg
	dosym rtextOben-kleo2-replay.mpg /usr/share/vdr/plugins/radio/replay.mpg

	exeinto /usr/share/vdr/plugins/radio
	doexe scripts/radioinfo*

	diropts -m 755 -o vdr -g vdr
	keepdir "/var/cache/vdr-radio"
}
