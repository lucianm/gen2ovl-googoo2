# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit rpm versionator user systemd

MY_PN="brscan-skey"
MY_PV="${PV}-${PR/r/}"

DESCRIPTION="Brother scan key tool for various models"

HOMEPAGE="http://support.brother.com"

#this version is for x86_64
SRC_URI="amd64? ( http://www.brother.com/pub/bsc/linux/dlf/${MY_PN}-${MY_PV}.x86_64.rpm )
x86? (	http://www.brother.com/pub/bsc/linux/dlf/${MY_PN}-${MY_PV}.i386.rpm ) "
LICENSE="Brother"

SLOT="0"

KEYWORDS="-* x86 amd64"

IUSE=""

RESTRICT="mirror strip"

RDEPEND="media-gfx/brother-scan4-bin
	media-libs/netpbm
	media-gfx/gimp
	virtual/mta
	|| ( app-text/cuneiform
		app-text/gocr
		app-text/ocrad )"
DEPEND="${RDEPEND}"

S=${WORKDIR}

pkg_setup() {
	enewgroup ${MY_PN} 289
	enewuser ${MY_PN} 289 -1 /srv/${MY_PN} ${MY_PN}
}

src_prepare() {
	epatch "${FILESDIR}/${MY_PN}-${MY_PV}_do-not-remove-SCRIPTDIR.patch" || die
	epatch "${FILESDIR}/${MY_PN}-${MY_PV}_fix-chmod-scantoemail-script.patch" || die
	epatch "${FILESDIR}/${MY_PN}-${MY_PV}_generate-scripts-cfg.patch" || die
	epatch "${FILESDIR}/${MY_PN}-${MY_PV}_scantoimage_gimp_fix.patch" || die
	epatch "${FILESDIR}/${MY_PN}-${MY_PV}_config-file-settings.patch" || die
}

src_install() {
	cp -r * "${D}" || die

	dosym ../../opt/brother/scanner/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}

	newinitd "${FILESDIR}/initd" "${MY_PN}"
	newconfd "${FILESDIR}/confd" "${MY_PN}"

	systemd_dounit "${FILESDIR}/${MY_PN}.service"
	systemd_newuserunit "${FILESDIR}/${MY_PN}-user.service" "${MY_PN}.service"

	dodir /srv/${MY_PN}
	insinto /srv/${MY_PN}
	doins "${FILESDIR}/.${MY_PN}.conf"

	fperms ugo+x "/srv/${MY_PN}"
	fowners -R "${MY_PN}:${MY_PN}" "/srv/${MY_PN}"
	fowners -R "${MY_PN}:${MY_PN}" "/opt/brother/scanner/${MY_PN}"
	fperms g+w "/opt/brother/scanner/${MY_PN}"
	fperms g+w "/opt/brother/scanner/${MY_PN}/script"
}

pkg_postinst() {
	einfo ""
	einfo "You can chose to run the '${MY_PN}' service under your own user by editing"
	einfo "/etc/conf.d/${MY_PN} if you use OpenRC,"
	einfo "or running the user unit of ${MY_PN} (systemctl --user start ${MY_PN})"
	einfo ""
	einfo "You need to be in the '${MY_PN}' group !!!!"
	einfo ""
	einfo "You may want to copy '/srv/${MY_PN}/.${MY_PN}.conf' to your own ~/ if"
	einfo "you want to customize the scripts."
}
