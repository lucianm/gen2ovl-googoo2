# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=8

RESTRICT="mirror bindist"

DESCRIPTION="Firmware for Micronas nGene based PCIe multimedia devices, like Linux4Media cineS2 DVB-S2 Twin tuner"
HOMEPAGE="http://linuxtv.org/wiki/index.php/Linux4Media_cineS2_DVB-S2_Twin_Tuner"
SRC_URI="https://github.com/OpenELEC/dvb-firmware/raw/master/firmware/ngene_${PV}.fw"

LICENSE="all-rights-reserved"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="sys-apps/coreutils"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	cp -L ${DISTDIR}/ngene_${PV}.fw .
}

src_install() {
	insinto /lib/firmware
	doins ngene_${PV}.fw
}
