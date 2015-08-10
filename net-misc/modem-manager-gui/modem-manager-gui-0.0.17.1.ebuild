# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="GUI for Modem Manager daemon."
HOMEPAGE="http://linuxonly.ru/"
SRC_URI="http://download.tuxfamily.org/gsf/source/${P}.tar.gz"

RESTRICT="nomirror"

inherit eutils

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ofono"


DEPEND=">=x11-libs/gtk+-3.4.0
	app-text/po4a
	dev-util/itstool
	x11-libs/libnotify"
RDEPEND="${DEPEND}
	ofono? ( net-misc/ofono )"

src_prepare() {
	epatch "${FILESDIR}/modem-manager-gui-0.0.17.1-fix-libebook-api-break-v2.patch"
	epatch "${FILESDIR}/str-length-test-0.0.17.1.patch"
}
