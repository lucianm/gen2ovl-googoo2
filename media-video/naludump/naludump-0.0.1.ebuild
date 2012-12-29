# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit eutils

IUSE=""

DESCRIPTION="Naludump - tool to delete NALU fill data (only complete TS packets) from h.264 streams embedded into TS files."
HOMEPAGE="http://www.udo-richter.de/vdr/naludump.html"
SRC_URI="http://www.udo-richter.de/vdr/files/${P}.tgz"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="GPL-2"

DEPEND="media-video/vdr
	app-misc/screen"

src_install() {
	dobin "${PN}"
	dobin "${FILESDIR}/naludump_vdr.sh"
	dodoc README
	insinto /usr/share/vdr/bin
	doins "${FILESDIR}/naludump_vdr_recording.sh"
	fperms ugo+x /usr/share/vdr/bin/naludump_vdr_recording.sh
}

pkg_postinst() {
	einfo ""
	einfo "You may add the following command to your \"/etc/vdr/reccmds/reccmds.custom.conf\":"
	einfo ""
	einfo "Strip h264 NALUs from recording		:/usr/share/vdr/bin/naludump_vdr_recording.sh"
	einfo ""
	einfo "And run it from your recordings menu for h264 recordings."
}
