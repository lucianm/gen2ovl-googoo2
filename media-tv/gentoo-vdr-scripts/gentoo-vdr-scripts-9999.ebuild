# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 user

EGIT_REPO_URI="https://github.com/lucianm/gentoo-vdr-scripts.git"

DESCRIPTION="Scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="https://gitweb.gentoo.org/proj/gentoo-vdr-scripts.git/about/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~x86"
IUSE=""

PDEPEND="media-tv/vdrcm"
DEPEND="acct-group/vdr
	acct-user/vdr"
RDEPEND="app-admin/sudo
	sys-process/wait_on_pid
	sys-apps/kbd
	sys-apps/util-linux
	sys-apps/gentoo-functions"

VDR_HOME=/var/lib/vdr
VDR_CACHE=/var/cache/vdr

#pkg_setup() {
#	enewgroup vdr

	# Add user vdr to these groups:
	#   video - accessing dvb-devices
	#   audio - playing sound when using software-devices
	#   cdrom - playing dvds/audio-cds ...
#	enewuser vdr -1 /bin/bash "${VDR_HOME}" vdr,video,audio,cdrom
#}

src_install() {
	default

	# create necessary directories
	diropts -ovdr -gvdr
	keepdir "${VDR_HOME}"

	keepdir "${VDR_HOME}/shutdown-data"
	keepdir "${VDR_HOME}/merged-config-files"
	keepdir "${VDR_HOME}/dvd-images"

	keepdir "${VDR_CACHE}"
}

VDRSUDOENTRY="vdr ALL=NOPASSWD:/usr/share/vdr/bin/vdrshutdown-really.sh"

pkg_postinst() {
	elog "${CATEGORY}/${PN} supports an init script"
	elog "to start a X server"
	elog "Please refer for detailed info to"
	elog "/usr/share/doc/${PF}/README.x11-setup\n"

	elog "systemd is supported by ${CATEGORY}/${PN}"
	elog "This are described in the README.systemd file"
	elog "in /usr/share/doc/${PF}/"

	einfo "nvram wakeup is supported optional."
	einfo "To make use of it emerge sys-power/nvram-wakeup.\n"

	elog "Plugins which should be used are set via"
	elog "the config-file called /etc/conf.d/vdr.plugins"
	elog "or enabled them via the frontend eselect vdr-plugin.\n"

	if [[ -f "${EROOT}"/etc/conf.d/vdr.dvdswitch ]] &&
		grep -q ^DVDSWITCH_BURNSPEED= "${EROOT}"/etc/conf.d/vdr.dvdswitch
	then
		ewarn "You are setting DVDSWITCH_BURNSPEED in /etc/conf.d/vdr.dvdswitch"
		ewarn "This no longer has any effect, please use"
		ewarn "VDR_DVDBURNSPEED in /etc/conf.d/vdr.cd-dvd"
	fi

	# backup routine for old /etc/sudoers entry
	if grep -q /usr/share/vdr/bin/vdrshutdown-really.sh "${EROOT}"/etc/sudoers; then
		ewarn "Please remove depricated entry from /etc/sudoers:"
		ewarn "${VDRSUDOENTRY}"
		ewarn "sudoers handling is supported by:"
		ewarn "/etc/sudoers.d/vdr"
	fi
}
