# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2 autotools multilib cmake-utils

ADDON="${PN/kodi-pvr-vdr/pvr.vdr.}"

EGIT_REPO_URI="git://github.com/kodi-pvr/${ADDON}.git"

DESCRIPTION="Kodi Isengard PVR Addon: VDR VNSI"
HOMEPAGE="https://github.com/kodi-pvr/${ADDON}"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/kodi-platform
	virtual/opengl
	!media-plugins/kodi-addon-pvrclients"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch_user

	cmake-utils_prepare
}
