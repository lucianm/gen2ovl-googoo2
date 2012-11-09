# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit eutils
# git-2

DESCRIPTION="Simple, persistent tmpfs ramdisk script"
HOMEPAGE="https://github.com/lucianm/RdPersist/"
SRC_URI="https://github.com/downloads/lucianm/RdPersist/${P}.tar.bz2"
#EGIT_REPO_URI="git://github.com/lucianm/RdPersist.git"

KEYWORDS="~amd64 ~x86"
#KEYWORDS=""

SLOT="0"
LICENSE="GPL-2"

RDEPEND="sys-apps/coreutils
	>=app-arch/lzop-1.02
	>=app-arch/tar-1.20"

DEPEND=${RDEPEND}

IUSE=""

src_install() {
	dobin "${PN}"
	insinto /etc
	doins "${PN}.conf"
	newinitd "${FILESDIR}/initd" "${PN}"
	dodoc AUTHORS README.md HISTORY TODO
}

pkg_postinst() {
	elog "You should configure '/etc/${PN}.conf' and then"
	elog "start '/etc/init.d/${PN}', which you can also"
	elog "add to the 'boot' runlevel"
}
