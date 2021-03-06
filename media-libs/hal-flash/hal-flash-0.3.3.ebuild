# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hal-flash/hal-flash-0.2.0_rc1.ebuild,v 1.2 2013/09/11 11:45:26 ssuominen Exp $

EAPI=5
inherit autotools eutils


DESCRIPTION="A libhal stub library forwarding to UDisks for www-plugins/adobe-flash to play DRM content"
HOMEPAGE="http://github.com/cshorler/hal-flash"
SRC_URI="https://github.com/cshorler/hal-flash/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="sys-apps/dbus
	!sys-apps/hal"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks:0"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

DOCS="README"

S=${WORKDIR}/${P}

src_prepare() { eautoreconf; }

src_install() {
	default
	prune_libtool_files
}
