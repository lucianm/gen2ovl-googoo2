# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"

inherit autotools-utils subversion

DESCRIPTION="LIRC helper daemon unifying and hotplugging event devices"
HOMEPAGE="http://code.google.com/p/${PN}/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="debug +ir-keytable"

DEPEND="app-misc/lirc
	sys-fs/udev"

RDEPEND="${DEPEND}
	ir-keytable? ( media-tv/v4l-utils )"


src_prepare() {
	# extract version reported by the program
	local progversion="$(grep '\[eventlircd\]' configure.ac | cut -d' ' -f2)"
	progversion="${progversion/\[/}"
	progversion="${progversion/\])/}"
	# add subversion revision to the version
	subversion_wc_info
	sed -i -e "s:${progversion}:${progversion}_svn${ESVN_WC_REVISION}:" configure.ac || die "sed configure.ac error on applying SVN revision"
	einfo "Modified version from \"${progversion}\" to  \"${progversion}_svn${ESVN_WC_REVISION}\""

	# fix upstream issue #3 and even a bit more (help output for -R option)
	epatch "${FILESDIR}/${P}_option-R.diff"

	# fix upstream issue #4:
	sed -i -e 's:AX_C_CHECK_FLAG(\[-Werror\]:dnl AX_C_CHECK_FLAG(\[-Werror\]:' configure.ac || die "sed configure.ac error on removing -Werror flag"

	# patch from OpenELEC.tv
	epatch "${FILESDIR}/${P}_repeat-0.1.diff"

	# adapt udev/lircd_helper.in to gentoo
	sed -i -e 's:@localstatedir@:/var:' udev/lircd_helper.in || die "sed udev/lircd_helper.in error on adapting @localstatedir@"
	sed -i -e 's:@sbindir@:/usr/sbin:' udev/lircd_helper.in || die "sed udev/lircd_helper.in error on adapting @sbindir@"

	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	local myeconfargs=(
		--with-lircd-socket="/var/run/lirc/lircd"
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	newconfd "${FILESDIR}/confd" "${PN}"
	newinitd "${FILESDIR}/initd" "${PN}"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
