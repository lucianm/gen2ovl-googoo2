# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: systeminfo"
HOMEPAGE="http://firefly.vdr-developer.org/systeminfo/"
SRC_URI="http://firefly.vdr-developer.org/systeminfo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nvidia"

DEPEND=">=media-video/vdr-1.7.34"

RDEPEND="sys-apps/lm_sensors
	app-admin/hddtemp
	nvidia? ( media-video/nvidia-settings )"

src_install() {
	vdr-plugin-2_src_install

	insinto /usr/share/vdr/plugins/systeminfo/
	insopts -m0755
	doins "${FILESDIR}"/systeminfo.sh
}
