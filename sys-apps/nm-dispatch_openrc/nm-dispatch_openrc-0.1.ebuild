# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit eutils

DESCRIPTION="NetworkManager Dispatcher OpenRC runlevel wrapper"
HOMEPAGE="http://www.gentoo-wiki.info/NetworkManager#Alternative:_NetworkManagerDispatcher_and_a_runlevel"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/networkmanager
	sys-apps/openrc"

S="${WORKDIR}"

src_install() {
	newconfd "${FILESDIR}/NetworkManagerDispatcher.confd" NetworkManagerDispatcher
	exeinto "/etc/NetworkManager/dispatcher.d"
	doexe "${FILESDIR}/99-openrc-runlevel_wrapper.sh"

	elog
	elog "Please create a pseudo-runlevel called exactly as the variable \"SERVICES_RUNLEVEL\""
	elog "defined in '/etc/conf.d/NetworkManagerDispatcher', then all you have to do is use"
	elog "'rc-update' to add openrc scripts to that runlevel."
	elog
	elog "Those scripts will be started only as soon as a network link is established."
	elog "A typical example of such a script you would like to start only after being online"
	elog "would be 'ntp-client'."
	elog
}

