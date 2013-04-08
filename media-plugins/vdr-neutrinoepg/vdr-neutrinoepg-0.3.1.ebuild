# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit vdr-plugin-2

if [ ${PV} == "9999" ] ; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-play.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/1342/${VDRPLUGIN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

DESCRIPTION="VDR plugin: Display EPG as classical neutrino show"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=media-video/vdr-1.7.43
	media-fonts/vdrsymbols-ttf"

DEPEND="${RDEPEND}"

