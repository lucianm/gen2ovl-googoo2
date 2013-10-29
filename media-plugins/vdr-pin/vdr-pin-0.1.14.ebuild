# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1379" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - PIN PlugIn"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0[pinplugin]"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${PN}-0.1.14_vdr-2.1.2.diff"

src_prepare() {
	vdr-plugin-2_src_prepare
	sed -i "s:INCLUDES += -I\$(VDRINCDIR):INCLUDES += -I\$(VDRDIR)/include:" Makefile
}

src_install() {
	vdr-plugin-2_src_install
	dobin fskcheck

	exeinto /usr/share/vdr/plugins/${VDRPLUGIN}
	doexe "${S}"/scripts/fskprotect.sh

	exeinto /usr/share/vdr/record
	newexe "${S}"/scripts/cut.sh preserve-pin-after-cut.sh

	insinto /etc/vdr/reccmds
	doins "${FILESDIR}"/reccmds.pin.conf
}
