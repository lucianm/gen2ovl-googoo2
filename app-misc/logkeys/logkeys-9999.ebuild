# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit systemd

DESCRIPTION="A GNU/Linux keylogger that works!"
HOMEPAGE="https://github.com/kernc/${PN}"

if [ "${PV}" = "9999" ]; then
	inherit git-r3 autotools-utils
	EGIT_REPO_URI="https://github.com/kernc/${PN}.git"
	KEYWORDS=""
else
	inherit eutils
	SRC_URI="https://github.com/kernc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="suid systemd"

RESTRICT="nomirror"

DEPEND=""
RDEPEND="${DEPEND}"

#PATCHES=( "${FILESDIR}/cxxflags.patch" )

src_prepare() {
	default
	epatch ${FILESDIR}/cxxflags.patch
	if [ "${PV}" = "9999" ]; then
		eautoreconf || die
	fi
}

src_install() {
	default

	insinto /usr/share/${PN}/
	doins keymaps/*.map

	newinitd "${FILESDIR}/${PN}-init.d" ${PN}
	newconfd "${FILESDIR}/${PN}-conf.d" ${PN}

	use systemd && systemd_dounit "${FILESDIR}/logkeys.service"
	use systemd && systemd_install_serviced "${FILESDIR}/logkeys.service.conf"

	if ! use suid; then
		rm -f "${D}"/etc/logkeys-{kill,start}.sh || die
		rm -f "${D}"/usr/bin/llk{,k} || die
	fi
}
