# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/vdr-skinsoppalusikka-1.6.4.ebuild,v 1.1 2009/04/14 20:07:21 zzam Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.7.30"
RDEPEND="${DEPEND}
	!x11-themes/vdr-channel-logos
	x11-themes/channel-logos-vdr"

S="${WORKDIR}/skinsoppalusikka-${PV}"

VDR_RCADDON_FILE="${FILESDIR}/rc-addon-1.0.2.sh"

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/themes
	doins "${S}"/themes/*.theme

	chown vdr:vdr -R "${D}"/etc/vdr
}
