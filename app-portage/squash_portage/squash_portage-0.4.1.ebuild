# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=7

inherit linux-info systemd

DESCRIPTION="Portage tree and overlays squasher scripts"
HOMEPAGE="https://github.com/init6/init_6/wiki/squashed-portage-tree"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd no_kernel_check"

RDEPEND="sys-libs/elog-functions
	sys-fs/squashfs-tools
	app-portage/eix
	systemd? ( sys-apps/systemd )"

S="${WORKDIR}"

pkg_setup() {
	if ! use no_kernel_check; then
		# define required kernel modules (or built-ins) to check for
		CONFIG_CHECK="BLK_DEV_LOOP SQUASHFS ~OVERLAY_FS"
		ERROR_BLK_DEV_LOOP="${P} requires CONFIG_BLK_DEV_LOOP support in the kernel"
		ERROR_SQUASHFS="${P} requires CONFIG_SQUASHFS support in the kernel"
		ERROR_OVERLAY_FS="${P} requires CONFIG_OVERLAY_FS support in the kernel"

		# now do those checks
		linux-info_pkg_setup
	fi
}

src_install() {
	newsbin "${FILESDIR}/${PN}.sh" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	use systemd && systemd_dounit "${FILESDIR}/${PN}.service"
	insinto "/etc/portage"
	doins "${FILESDIR}/${PN}.conf"
}

pkg_postinst() {
	einfo "Before running '${PN} start' for the first time,"
	einfo "Please perform the following operations:"
	einfo ""
	einfo "1. Edit /etc/make.conf to adapt the following values:"
	einfo ""
	einfo "	PORTAGE_FOLDER=\"/var/portage\""
	einfo "	PORTDIR=\"\${PORTAGE_FOLDER}/portage\""
	einfo "	PORTDIR_OVERLAY=\""
	einfo "	\${PORTAGE_FOLDER}/local/overlay_one"
	einfo "	\${PORTAGE_FOLDER}/local/overlay_two"
	einfo "	\""
	einfo "	source /var/portage/layman/make.conf"
	einfo ""
	einfo "Optionally, you can also adapt these:"
	einfo "	DISTDIR=\"\${PORTAGE_FOLDER}/distfiles\""
	einfo "	PKGDIR=\"\${PORTAGE_FOLDER}/packages\""
	einfo ""
	einfo "2. Also edit /etc/layman/layman.cfg to modify the storage variable"
	einfo "to point to '/var/portage/layman'"
	einfo "3. now run '${PN} start' to create and mount the sqashed portage volumes"
	einfo "4. run 'sync portage'"
	einfo "5. correct symlink '/etc/make.profile' to point to the new location"
	einfo "6. add layman overlays"
	einfo "7. run 'eix-update'"
	einfo ""
	einfo "8. If you need to tweak your configuration, do so in /etc/portage/${PN}.conf"
	einfo ""
	einfo "Now you can enable the ${PN} service in OpenRC or in systemd."
	einfo "Every time you want to sync portage and layman, just run '${PN} sync'"
	einfo "To make any changes occured otherwise than by the sync command above persistent,"
	einfo "run '${PN} restart'"
}
