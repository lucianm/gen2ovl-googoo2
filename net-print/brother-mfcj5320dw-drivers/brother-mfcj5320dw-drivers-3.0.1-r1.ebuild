# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib rpm

WRAPPER_VER="${PV}-${PR/r/}"
LPR_VER="${PV}-${PR/r/}"
GPL_VER="${PV}-${PR/r/}"
BROTHER_MODEL=${PN/brother-/}
BROTHER_MODEL=${BROTHER_MODEL/-drivers/}


DESCRIPTION="LPR and CUPS drivers for the Brother MFC-J5320DW Business Smart Plus Inkjet All-in-One"
HOMEPAGE="http://support.brother.com/g/b/downloadlist.aspx?c=de&lang=de&prod=mfcj5320dw_eu_as&os=127&flang=English"
SRC_URI="http://download.brother.com/welcome/dlf101593/${BROTHER_MODEL}lpr-${LPR_VER}.i386.rpm
	http://download.brother.com/welcome/dlf101594/${BROTHER_MODEL}cupswrapper-${WRAPPER_VER}.i386.rpm"
#	http://download.brother.com/welcome/dlf101608/brother_${BROTHER_MODEL}_GPL_source_${GPL_VER}.tar.gz"

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
	dosym ../../../../opt/brother/Printers/${BROTHER_MODEL}/lpd/filter${BROTHER_MODEL} /usr/libexec/cups/filter/brother_lpdwrapper_${BROTHER_MODEL}
}

pkg_postinst() {
	einfo ""
	einfo "To add the Brother MFC-J5320DW to CUPS,"
	einfo "make sure that the CUPS daemon is running"
	einfo "and run:"
	einfo "           emerge ${CATEGORY}/${PN} --config"
	einfo ""
}

pkg_config() {
	# add printer to CUPS
	/opt/brother/Printers/${BROTHER_MODEL}/cupswrapper/cupswrapper${BROTHER_MODEL}
}
