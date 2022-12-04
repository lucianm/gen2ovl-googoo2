# Copyright 2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit vdr-plugin-2

# Versioning of this plugin is a bit complicated, since kls keeps it in the main VDR sources and sometimes
# commits some updates to the plugin itself without bumping the actual version of the plugin.
# Therefore the plugin version often stays behind the fixes, so it is safer to grab the plugin source
# from a more recent vdr package. As of now, 2022.12.04, vdr-2.6.2 is out, so let's use this version:

VDR_PV="2.6.2"


DESCRIPTION="VDR plugin: show content of menu in a shell window"
HOMEPAGE="http://www.tvdr.de/"
SRC_URI="http://git.tvdr.de/?p=vdr.git;a=snapshot;h=refs/tags/${VDR_PV};sf=tbz2 -> vdr-${VDR_PV}.tbz2"

KEYWORDS="amd64 x86 ~arm ~arm64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-${PV}"

S="${WORKDIR}/vdr-${VDR_PV}/PLUGINS/src/${VDRPLUGIN}"

#PATCHES="${FILESDIR}/vdr-2.4.1-fix-skincurses-min.diff"
