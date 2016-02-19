# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2

VERSION="1971" # every bump, new version

DESCRIPTION="VDR Plugin: allows remote programming VDR using VDR-Manager running on Android devices"
HOMEPAGE="http://projects.vdr-developer.org/projects/vdr-manager/wiki"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="-stream"

DEPEND=">=media-video/vdr-2"
RDEPEND="stream? ( media-plugins/vdr-streamdev[server] )"

S="${WORKDIR}/${P}"

VDR_RCADDON_FILE_4ARGSDIR="${FILESDIR}/rc-addon_4argsdir.sh"

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "Add a password to /etc/conf.d/vdr.vdrmanager"
}
