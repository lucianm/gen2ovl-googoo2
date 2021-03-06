# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user systemd git-2
EGIT_REPO_URI="${MINISATIP_EGIT_REPO_URI:-git://github.com/catalinii/minisatip.git}"
DESCRIPTION="SAT>IP server using local DVB-S, DVB-S2, DVB-T, DVB-T2, DVB-C, DVB-C2, ATSC and ISDB-T cards"
HOMEPAGE="https://github.com/catalinii/minisatip"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

IUSE="client_netceiver +client_satip dvbca +dvbcsa embedded static_libs"

REQUIRED_USE="dvbca? ( dvbcsa )"

DEPEND="dvbcsa? ( media-libs/libdvbcsa )
	media-tv/linuxtv-dvb-apps"

RDEPEND="${DEPEND}
	dvbcsa? ( media-tv/oscam[dvbapi] )"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /tmp ${PN},video,audio,uucp
}

src_prepare() {
	epatch_user
}

src_compile() {
	unset LDFLAGS
	emake \
		DVBCA=$(usex dvbca yes no) \
		DVBCSA=$(usex dvbcsa yes no) \
		SATIPCLIENT=$(usex client_satip yes no) \
		NETCVCLIENT=$(usex client_netceiver yes no) \
		EMBEDDED=$(usex embedded yes no) \
		STATIC=$(usex static_libs yes no)
}

src_install() {

	dobin ${PN}

	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}

	insinto "/usr/share/${PN}"
	doins -r html

	systemd_dounit "${FILESDIR}/${PN}.service"

	dodoc README*

	dodir "/tmp/log"
	fowners -R ${PN}:${PN} "/tmp/log"
}

pkg_postinst() {
	einfo "For any assistance with the setup please refer to the homepage"
	einfo "     located at ${HOMEPAGE} "
	einfo "It also contains valuable links to further information"
}
