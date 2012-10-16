# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools git-2 eutils

DESCRIPTION="Userspace controler for mbm-gpsd"
HOMEPAGE="http://mbm.sourceforge.net/"
EGIT_REPO_URI="git://mbm.git.sourceforge.net/gitroot/mbm/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

DEPEND="sys-apps/dbus
	dev-libs/glib:2
	x11-libs/gtk+:2
	gnome-base/gconf:2
	dev-libs/nss
	sci-geosciences/mbm-gpsd
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}_gthread.patch"
	eautoreconf
	intltoolize --force
	eautoreconf
}

src_configure() {
	econf \
		--enable-maintainer-mode \
		--with-distro=gentoo \
		$(use_enable nls nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc NEWS README || die
}
