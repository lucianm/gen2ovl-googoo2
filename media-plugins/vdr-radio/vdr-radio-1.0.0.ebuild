# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: show background image for radio and decode RDS Text"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=58795"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/vdr-1.7.37"
DEPEND="${RDEPEND}"

src_install() {

	vdr-plugin-2_src_install
	
	dodoc LIESMICH.bitte config/scripts/LIESMICH.Scripts

	cd "${S}"/config/mpegstill
	insinto /usr/share/vdr/plugins/${VDRPLUGIN}
	doins radio-*.mpg
	doins rtext*.mpg
	
	for mpg in $(ls *-*.mpg); do
		dosym /usr/share/vdr/plugins/${VDRPLUGIN}/${mpg} /etc/vdr/plugins/${VDRPLUGIN}/${mpg}
	done

	cd "${S}"/config/scripts
	exeinto /usr/share/vdr/plugins/${VDRPLUGIN}
	doexe radioinfo*
	for script in $(ls radioinfo-*); do
		dosym /usr/share/vdr/plugins/${VDRPLUGIN}/${script} /etc/vdr/plugins/${VDRPLUGIN}/${script}
	done
	
	dodir /var/cache/vdr/plugins/${VDRPLUGIN}
	fowners -R vdr:vdr /var/cache/vdr/plugins/${VDRPLUGIN}
}
