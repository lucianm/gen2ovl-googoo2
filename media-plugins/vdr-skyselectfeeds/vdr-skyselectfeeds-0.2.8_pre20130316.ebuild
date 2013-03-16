# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: use the multifeed option of some Sky Germany (former Premiere) channels - fork of vdr-arghdirector"
HOMEPAGE="http://www.arghgra.de/arghdirector.html"
SRC_URI="http://sourceforge.net/projects/skyselectfeeds/files/0.2.8/${P}.tgz
	mirror://vdrfiles/${P}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">media-video/vdr-1.7.27"
RDEPEND="${DEPEND}
	!media-plugins/vdr-director
	!media-plugins/vdr-arghdirector"
