# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrmanager/vdr-vdrmanager-0.6-r1.ebuild,v 1.1 2012/03/02 23:33:48 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: allows remote programming VDR using VDR-Manager running on Android devices"
HOMEPAGE="http://projects.vdr-developer.org/projects/vdr-manager"
SRC_URI="http://projects.vdr-developer.org/projects/vdr-manager/repository/revisions/master/raw/release/vdr-vdrmanager-${PV}.tar.gz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

IUSE="-stream"

DEPEND=">=media-video/vdr-1.6.0"

RDEPEND="stream? ( media-plugins/vdr-streamdev[server] )"

S="${WORKDIR}/${P}"

src_install() {
	vdr-plugin_src_install

	insinto /etc/conf.d
	newins examples/vdr.vdrmanager vdr.vdrmanager
	fperms 600 /etc/conf.d/vdr.vdrmanager
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "Add a password to /etc/conf.d/vdr.vdrmanager"
}
