# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2 autotools multilib cmake-utils

EGIT_REPO_URI="git://github.com/Pulse-Eight/platform.git"

DESCRIPTION="Platform Support Library used by libCEC and binary addons for Kodi"
HOMEPAGE="https://github.com/Pulse-Eight/platform"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch_user

	cmake-utils_prepare
}
