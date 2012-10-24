# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin eutils git-2

#VERSION="1065" #every bump, new version

DVDARCHIVE="dvdarchive.sh"

DESCRIPTION="Video Disk Recorder - Plugin for modifying EPG data using regular expressions"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${VDRPLUGIN}"
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
S="${WORKDIR}/${VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr
	doins -r "${VDRPLUGIN}"
}
