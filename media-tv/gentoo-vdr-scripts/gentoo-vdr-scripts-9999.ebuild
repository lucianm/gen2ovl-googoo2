# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit git-r3 user

EGIT_REPO_URI="git://github.com/lucianm/gentoo-vdr-scripts.git"

DESCRIPTION="Scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="nvram"

PDEPEND="media-tv/vdrcm"

RDEPEND="nvram? ( sys-power/nvram-wakeup )
	app-admin/sudo
	sys-process/wait_on_pid
	sys-apps/gentoo-functions"

VDR_HOME=/var/vdr

pkg_setup() {
	enewgroup vdr

	# Add user vdr to these groups:
	#   video - accessing dvb-devices
	#   audio - playing sound when using software-devices
	#   cdrom - playing dvds/audio-cds ...
	enewuser vdr -1 /bin/bash "${VDR_HOME}" vdr,video,audio,cdrom
}

src_prepare() {
	epatch_user
}

src_install() {
	default
	nonfatal dodoc README* TODO ChangeLog

	# create necessary directories
	diropts -ovdr -gvdr
	keepdir "${VDR_HOME}"

local kd
	for kd in shutdown-data merged-config-files dvd-images; do
		keepdir "${VDR_HOME}/${kd}"
	done
}
