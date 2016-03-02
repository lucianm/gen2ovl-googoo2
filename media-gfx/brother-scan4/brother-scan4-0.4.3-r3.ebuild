# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

#based on ebuilds from the funtoo and flow overlay

inherit rpm versionator

MY_PN="brscan4"
MY_PV="${PV}-${PR/r/}"

DESCRIPTION="Brother SANE backend ('${MY_PN}' for various models)"

HOMEPAGE="http://support.brother.com"

#this version is for x86_64
SRC_URI="amd64? ( http://download.brother.com/welcome/dlf006648/${MY_PN}-${MY_PV}.x86_64.rpm )
x86? (	http://download.brother.com/welcome/dlf006647/${MY_PN}-${MY_PV}.i386.rpm ) "
LICENSE="Brother"

SLOT="0"

KEYWORDS="-* x86 amd64"

IUSE=""

RESTRICT="mirror strip"

DEPEND="dev-libs/libusb-compat
	media-gfx/sane-backends[usb]"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	cp -r * "${D}" || die

	# so no files from the sane package are touched
	mkdir -p "${D}/etc/sane.d/dll.d"
	echo "brother4" >"${D}/etc/sane.d/dll.d/brscan4.conf"
}

pkg_postinst() {
	einfo ""
	einfo "To add the Brother scanner backend for your specific model, find the correct"
	einfo "one from the output of the command:"
	einfo "         brsaneconfig4 -q"
	einfo "Example with MFC-7460DN over network:"
	einfo "         brsaneconfig4 -a name=mfcscan model=MFC-7460DN ip=192.168.10.6"
	einfo "You can also use nodename=network_name_of_your_scanner instead of ip=....."

	elog "You may need to be in the scanner or plugdev group in order to use the scanner"
}
