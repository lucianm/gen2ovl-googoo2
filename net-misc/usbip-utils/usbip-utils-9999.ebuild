# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools-utils toolchain-funcs linux-info systemd git-2

DESCRIPTION="Userspace tools for USB-IP (general USB device sharing system over IP networks)"
HOMEPAGE="http://usbip.sourceforge.net/"
#EGIT_REPO_URI="git://github.com/rosedu/usbip-utils.git"
EGIT_REPO_URI="git://github.com/lucianm/usbip-utils.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="virtual/libusb:0
	sys-apps/tcp-wrappers
	virtual/pkgconfig"

RDEPEND="${DEPEND}
	virtual/modutils"

DOCS=(README)

pkg_setup() {
	CONFIG_CHECK="USB_IP_COMMON"
	CONFIG_CHECK="USB_IP_VHCI_HCD"
	CONFIG_CHECK="USB_IP_HOST"
}

src_prepare() {
	eautoreconf
}

src_configure() {
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	newinitd "${FILESDIR}/usbipd.initd" usbipd
	systemd_dounit contrib/usbipd.service
}
