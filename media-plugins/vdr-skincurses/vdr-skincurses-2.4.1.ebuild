# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: show content of menu in a shell window"
HOMEPAGE="http://www.tvdr.de/"
#SRC_URI="ftp://ftp.tvdr.de/vdr/Developer/vdr-${PV}.tar.bz2"
SRC_URI="ftp://ftp.tvdr.de/vdr/vdr-${PV}.tar.bz2"

KEYWORDS="~amd64 ~x86 ~arm"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-${PV}"

S="${WORKDIR}/vdr-${PV}/PLUGINS/src/${VDRPLUGIN}"
