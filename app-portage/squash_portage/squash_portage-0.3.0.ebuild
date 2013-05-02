# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit linux-info systemd

DESCRIPTION="Portage tree and overlays squasher scripts"
HOMEPAGE="http://en.gentoo-wiki.com/wiki/Squashed_Portage_Tree"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="sys-libs/elog-functions
	sys-fs/squashfs-tools
	app-portage/eix
	systemd? ( sys-apps/systemd )"

S="${WORKDIR}"

pkg_setup() {
	# define required kernel modules (or built-ins) to check for
	CONFIG_CHECK="BLK_DEV_LOOP SQUASHFS ~AUFS_FS"
	ERROR_BLK_DEV_LOOP="${P} requires CONFIG_BLK_DEV_LOOP support in the kernel"
	ERROR_SQUASHFS="${P} requires CONFIG_SQUASHFS support in the kernel"
	ERROR_AUFS_FS="${P} requires CONFIG_AUFS_FS support in the kernel (either patch the kernel or use sys-kernel/aufs-sources or emerge sys-fs/aufs3"

	# now do those checks
	linux-info_pkg_setup
}

src_install() {
	newsbin "${FILESDIR}/${PN}.sh" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	use systemd && systemd_dounit "${FILESDIR}/${PN}.service"
	insinto "/etc/portage"
	doins "${FILESDIR}/${PN}.conf"
}
