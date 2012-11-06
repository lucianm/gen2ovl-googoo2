# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2 eutils

VERSION="1065" #every bump, new version

DVDARCHIVE="dvdarchive.sh"

DESCRIPTION="Video Disk Recorder - Plugin for modifying EPG data using regular expressions"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${VDRPLUGIN}"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
	dev-libs/libpcre"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins
	doins -r "${VDRPLUGIN}"
}
