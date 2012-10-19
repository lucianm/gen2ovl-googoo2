# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="4"

inherit eutils flag-o-matic multilib

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://projects.vdr-developer.org/projects/graphlcd"
SRC_URI="http://projects.vdr-developer.org/attachments/download/501/${P}.tgz"

KEYWORDS="~amd64 ~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="g15 serdisplib"

DEPEND=""

RDEPEND="g15? ( app-misc/g15daemon )
	serdisplib? ( dev-libs/serdisplib )"

src_prepare() {

	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:"
	epatch "${FILESDIR}/0.1.9/${PN}-0.1.5-nostrip.patch"
	epatch "${FILESDIR}/0.1.9/${PN}-0.1.6.20100408_valgrind_v2.patch"
	epatch "${FILESDIR}/0.1.9/${PN}-0.1.9_noritake800.patch"
	epatch "${FILESDIR}/0.1.9/${PN}-0.1.9_utf8_v3.patch"
	epatch "${FILESDIR}/0.1.9/${PN}-0.1.9_utf8_v4-sequence-detect-consolidate.patch"
	epatch_user
}

src_install() {

	make DESTDIR="${D}"/usr LIBDIR="${D}"/usr/$(get_libdir) install || die "make install failed"

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
