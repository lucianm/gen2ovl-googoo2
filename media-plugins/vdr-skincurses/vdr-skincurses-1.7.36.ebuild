# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

IUSE=""

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: show content of menu in a shell window"
HOMEPAGE="http://www.tvdr.de"
SRC_URI="ftp://ftp.tvdr.de/vdr/Developer/vdr-${PV}.tar.bz2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-${PV}"

S=${WORKDIR}/vdr-${PV}/PLUGINS/src/${VDRPLUGIN}
