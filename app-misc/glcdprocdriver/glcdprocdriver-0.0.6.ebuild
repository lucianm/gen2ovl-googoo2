# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Glue library for the glcdlib LCDproc driver based on GraphLCD"
HOMEPAGE="http://www.muresan.de/graphlcd/lcdproc/"
SRC_URI="http://www.muresan.de/graphlcd/lcdproc/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=app-misc/graphlcd-base-0.1.3
	<=app-misc/graphlcd-base-0.1.9"
RDEPEND=${DEPEND}

IUSE="debug"

src_compile() {
	if use debug; then
		filter-flags -O2 -O1
		append-flags -g -ggdb -O0
		filter-ldflags -O2 -O1
		append-ldflags -g -ggdb -O0
	fi

	emake
#	emake LDFLAGS="${LDFLAGS}" CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}"
}

src_install()
{
	emake DESTDIR="${D}/usr" LIBDIR="${D}/usr/$(get_libdir)" install
	dodoc AUTHORS README INSTALL TODO ChangeLog
}
