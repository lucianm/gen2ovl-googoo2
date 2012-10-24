# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin eutils git

#VERSION="936" #every bump, new version

DVDARCHIVE="dvdarchive.sh"

DESCRIPTION="Video Disk Recorder - Extended recordings menu Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-extrecmenu"
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
S="${WORKDIR}/${VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {

	cd "${WORKDIR}"
#	epatch "${FILESDIR}/${DVDARCHIVE%.sh}-configfile.patch"

	cd "${S}"
	if grep -q fskProtection /usr/include/vdr/timers.h; then
		einfo "Enabling parentalrating option"
		sed -i "s:#WITHPINPLUGIN:WITHPINPLUGIN:" Makefile
	fi

	vdr-plugin_src_prepare

	if has_version ">=media-video/vdr-1.7.18"; then
		sed -e "s:Read(f):Read():" -i mymenueditrecording.c
	fi

#	if has_version ">=media-video/vdr-1.7.27"; then
#		epatch "${FILESDIR}/vdr-1.7.27.diff"
#	fi
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"
	newbin scripts/${DVDARCHIVE} dvdarchive.sh

	insinto /etc/vdr
	doins "${FILESDIR}"/dvdarchive.conf
}
