# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Wrapper for java-config"
HOMEPAGE="https://www.gentoo.org/proj/en/java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND="!<dev-java/java-config-1.3"
RDEPEND="app-portage/portage-utils
	>=sys-apps/gentoo-functions-0.10"

src_prepare() {
	sed -i src/shell/java-1.5-fixer -e 's:/etc/init.d/functions.sh:/lib/gentoo/functions.sh:'
	sed -i src/shell/java-check-environment -e 's:/etc/init.d/functions.sh:/lib/gentoo/functions.sh:'
}

src_install() {
	dobin src/shell/* || die
	dodoc AUTHORS || die
}
