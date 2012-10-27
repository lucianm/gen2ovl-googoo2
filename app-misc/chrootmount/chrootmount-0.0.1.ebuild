# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Chroot mounter / unmounter service and utilities"

HOMEPAGE="http://www.muresan.de/${PN}"

SRC_URI="${HOMEPAGE}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64 ~arm"

IUSE=""

RDEPEND="sys-apps/openrc"

# add build-only dependencies
DEPEND="${RDEPEND}"

src_install() {
	DESTDIR="${D}" einstall
	prepalldocs
	newconfd samples/conf.d/${PN} ${PN}.sample
}
