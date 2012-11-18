# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
#
# Author:
#   Lucian Muresan <lucianm@users.sourceforge.net>

# channel-logos.eclass
#
#   eclass to easily add local patches to ebuilds
#
# based upon x11-themes/vdr-channel-logos and x11-themes/skinenigmang-logos, inspired from
# vdr-plugin-2.eclass
#   Joerg Bornkessel <hd_brummy@gentoo.org>

inherit eutils

EXPORT_FUNCTIONS src_prepare

IUSE=""

# channel logos base installation dir
CHANLOGOBASE="/usr/share/channel-logos"

# logo pack name as derived from package name
LOGOPACKNAME="${PN/channel-logos-//}"

DESCRIPTION="Channel logos "${LOGOPACKNAME}" to be used by vdr-skin* plugins and possibly other programs, too"

# might just work
S="${WORKDIR}/${LOGOPACKNAME}"

# on emerging, names will be converted to utf-8
DEPEND="app-text/convmv
	app-arch/unzip"

channel-logos_src_prepare() {
	epatch_user
	convmv --notest --replace -f iso-8859-1 -t utf-8 -r "${S}"/
}
