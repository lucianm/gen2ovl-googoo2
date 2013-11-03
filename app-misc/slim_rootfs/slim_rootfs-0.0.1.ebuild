# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit systemd

DESCRIPTION="RootFS diet cure"
HOMEPAGE="https://www.github.com/lucianm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="sys-libs/elog-functions
	systemd? ( sys-apps/systemd )"

S="${WORKDIR}"


src_install() {
	newsbin "${FILESDIR}/${PN}.sh" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	use systemd && systemd_dounit "${FILESDIR}/${PN}.service"
	insinto "/etc"
	doins "${FILESDIR}/${PN}.conf"
}

pkg_postinst() {
	einfo "Before running '${PN}' for the first time,"
	einfo "Please add full paths of files or directories to be deleted to"
	einfo "the DEL_OBJ_PATHS variable in /etc/${PN}.conf, possibly with wildcards"
}
