# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Manages the VDR plugins"
HOMEPAGE="https://www.gentoo.org/"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
EGIT_REPO_URI="https://github.com/lucianm/${PN}.git"

inherit git-r3

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3"

src_install() {
	insinto /usr/share/eselect/modules
	doins vdr-plugin.eselect || die "Could not install eselect module"

	dosym /usr/bin/eselect /usr/bin/vdr-plugin-config
}
