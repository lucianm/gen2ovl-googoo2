# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit eutils flag-o-matic multilib toolchain-funcs

MY_PN="GLCDprocDriver"

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/lucianm/${MY_PN}.git"
	KEYWORDS=""
	S="${WORKDIR}/${MY_PN}"
else
	SRC_URI="https://github.com/lucianm/${MY_PN}/archive/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~ppc"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

DESCRIPTION="Glue library for the glcdlib LCDproc driver based on GraphLCD"
HOMEPAGE="http://lucianm.github.com/${MY_PN}/"

SLOT="0"
LICENSE="GPL-2"

DEPEND=">app-misc/graphlcd-base-0.1.9"
RDEPEND=${DEPEND}

IUSE="debug"

src_prepare() {
	epatch_user
}

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
	dodoc AUTHORS README.md INSTALL TODO ChangeLog
}
