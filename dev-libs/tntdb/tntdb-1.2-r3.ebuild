# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A c++-class-library for easy and light database-access. Currently for postgresql, sqlite3 and mysql"
HOMEPAGE="http://www.tntnet.org/tntdb.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mysql postgres sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

RDEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	sqlite? ( dev-db/sqlite:3 )
	>=dev-libs/cxxtools-2.1"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	econf \
		$(use_with mysql) \
		$(use_with postgres postgresql) \
		$(use_with sqlite) \
		$(use_with doc doxygen) \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	dodoc doc/*.pdf

	insinto /usr/share/doc/${PF}/examples
	doins demo/*.{cpp,h}
}
