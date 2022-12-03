# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "9999" ]]; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/lucianm/${PN}.git"

	inherit git-r3
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~x86"
else
	SRC_URI="https://github.com/lucianm/${PN}/archive/refs/tags/${P}.tar.gz"
	KEYWORDS="amd64 ~arm ~arm64 ~ppc x86"
fi

DESCRIPTION="Manages the VDR plugins"
HOMEPAGE="https://gitweb.gentoo.org/proj/gentoo-vdr-scripts.git/?h=eselect-module"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	doins vdr-plugin.eselect

	dosym eselect /usr/bin/vdr-plugin-config
}
