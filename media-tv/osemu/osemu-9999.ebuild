# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils systemd git-2

MY_PN="OSEmu"

EGIT_REPO_URI="${OSEMU_EGIT_REPO_URI:-git://github.com/oscam-emu/${MY_PN}.git}"

DESCRIPTION="${MY_PN} is an Open Source Conditional Access Module emulator"
HOMEPAGE="http://github.com/oscam-emu/${MY_PN}"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

RESTRICT="nomirror"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
#	sed -i 's:CFLAGS=-I.:#CFLAGS=-I. -DWITH_LIBCRYPTO:' Makefile || die "enabling OpenSSL in  Makefile failed"
	sed -i 's:	$(STRIP):#	$(STRIP):' Makefile || die "disabling Makefile stripping failed"
}

src_install() {
	emake all || die "install target failed"

	dobin "${MY_PN}"
	
	dodoc README

	dobin "${FILESDIR}/osemu_watchdog.sh" || die "dobin osemu_watchdog.sh failed"

	newinitd "${FILESDIR}/${PN}.initd" osemu
	newconfd "${FILESDIR}/${PN}.confd" osemu

	systemd_dounit "${FILESDIR}/${PN}.service"

	dodir "/var/log/${PN}"
}
