# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools git-2 eutils

DESCRIPTION="gpsd-conform daemon for mobile broadband devices f3507g, f3607gw and f5521gw"
HOMEPAGE="http://mbm.sourceforge.net/"
EGIT_REPO_URI="git://mbm.git.sourceforge.net/gitroot/mbm/${PN}"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc nls"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc nls"

DEPEND="sys-apps/dbus
	dev-libs/glib:2
	sys-fs/udev
	dev-libs/nss
	nls? ( virtual/libintl )
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.0 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	use nls && intltoolize --force
	eautoreconf
	./autogen.sh
}

src_configure() {
#                --enable-maintainer-mode \
	econf \
		--with-distro=gentoo \
		$(use_with doc docs) \
		$(use_enable nls nls)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README
}
