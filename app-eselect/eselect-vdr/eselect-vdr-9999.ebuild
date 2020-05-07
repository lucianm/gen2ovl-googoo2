# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Manages the VDR plugins"
HOMEPAGE="https://gitweb.gentoo.org/proj/gentoo-vdr-scripts.git/?h=eselect-module"
#SRC_URI="http://vdr.websitec.de/download/eselect-vdr/${P}.tar.bz2"
EGIT_REPO_URI="https://github.com/lucianm/${PN}.git"

inherit git-r3

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	doins vdr-plugin.eselect

	dosym eselect /usr/bin/vdr-plugin-config
}
