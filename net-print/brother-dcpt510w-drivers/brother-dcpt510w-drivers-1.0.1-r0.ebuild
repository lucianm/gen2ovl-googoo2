# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib rpm

WRAPPER_VER="${PV}-${PR/r/}"
LPR_VER="${PV}-${PR/r/}"
GPL_VER="${PV}-${PR/r/}"
BROTHER_MODEL=${PN/brother-/}
BROTHER_MODEL=${BROTHER_MODEL/-drivers/}


DESCRIPTION="LPR and CUPS drivers for the Brother DCP-T510WP Inkjet All-in-One"
HOMEPAGE="https://support.brother.com/g/b/producttop.aspx?c=eu_ot&lang=en&prod=dcpt510w_all"
SRC_URI="https://download.brother.com/welcome/dlf103621/${BROTHER_MODEL}pdrv-${LPR_VER}.i386.rpm"
#	https://download.brother.com/welcome/dlf103621/${BROTHER_MODEL}cupswrapper-${WRAPPER_VER}.i386.rpm"
#	http://download.brother.com/welcome/dlf101608/brother_${BROTHER_MODEL}_GPL_source_${GPL_VER}.tar.gz"
#https://download.brother.com/welcome/dlf103621/dcpt510wpdrv-1.0.1-0.i386.rpm

LICENSE="Brother"
# GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="usb"

DEPEND="${DEPEND}"
RDEPEND="app-text/ghostscript-gpl
	net-print/cups
	usb? ( dev-libs/libusb-compat )"
if [[ "${ARCH}" = "amd64" ]]; then
	RDEPEND="${RDEPEND}
	sys-libs/glibc[abi_x86_32(+)]"
fi

S="${WORKDIR}"

RESTRICT="mirror strip"

src_prepare() {
	chmod ugo-x opt/brother/Printers/${BROTHER_MODEL}/cupswrapper/brother_${BROTHER_MODEL}_printer_en.ppd
}

src_install() {
	cp -R * "${D}" || die
	dosym ../../../../opt/brother/Printers/${BROTHER_MODEL}/lpd/filter_${BROTHER_MODEL} /usr/libexec/cups/filter/brother_lpdwrapper_${BROTHER_MODEL}
}

pkg_postinst() {
	einfo ""
	einfo "To add the Brother DCP-T510WP to CUPS,"
	einfo "make sure that the CUPS daemon is running"
	einfo "and run:"
	einfo "           emerge ${CATEGORY}/${PN} --config"
	einfo ""
}

pkg_config() {
	# add printer to CUPS
	/opt/brother/Printers/${BROTHER_MODEL}/cupswrapper/cupswrapper${BROTHER_MODEL}
}
