# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

IUSE=""

inherit vdr-plugin

DESCRIPTION="VDR plugin: show content of menu in a shell window"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="ftp://ftp.tvdr.de/vdr/Developer/vdr-${PV}.tar.bz2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-${PV}"

S=${WORKDIR}/vdr-${PV}/PLUGINS/src/${VDRPLUGIN}
