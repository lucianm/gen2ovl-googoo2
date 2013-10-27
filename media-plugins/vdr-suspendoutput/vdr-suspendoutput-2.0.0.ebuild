# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Show still image instead of live tv to safe cpu"
HOMEPAGE="http://phivdr.dyndns.org/vdr/vdr-suspendoutput/"
SRC_URI="http://phivdr.dyndns.org/vdr/vdr-suspendoutput/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-2.0.0"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/suspendoutput-2.0.0_vdr-2.1.2.diff"
