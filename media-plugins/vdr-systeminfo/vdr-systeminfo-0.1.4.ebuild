# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: ${VDRPLUGIN}"
HOMEPAGE="http://firefly.vdr-developer.org/${VDRPLUGIN}/"
SRC_URI="http://firefly.vdr-developer.org/${VDRPLUGIN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nvidia"

DEPEND=">=media-video/vdr-1.7.34"

RDEPEND="sys-apps/lm_sensors
		app-admin/hddtemp
		nvidia? ( media-video/nvidia-settings )"

src_prepare() {
	vdr-plugin-2_src_prepare
	
	# adapt script
	epatch "${FILESDIR}/${VDRPLUGIN}.sh_0.1.4_gentoo.diff"

	# Makefile correction, .eclass fails in some Makefiles
	sed -e "s:(VDRINCDIR):(VDRDIR)/include:" -i Makefile

	sed -e "s:#define BARLEN 30:#define BARLEN 35:" -i displayinfo.c || die
}

src_install() {
	vdr-plugin-2_src_install

	insinto /usr/share/vdr/plugins/${VDRPLUGIN}/
	insopts -m0755
	doins scripts/${VDRPLUGIN}.sh

	insinto /etc/sudoers.d
	insopts -m440
	newins "${FILESDIR}/${PN}.sudo" ${PN}
}
