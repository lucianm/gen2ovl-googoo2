# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2 autotools multilib cmake-utils

ADDON="${PN/kodi-pvr-/pvr.}"

EGIT_REPO_URI="git://github.com/kodi-pvr/${ADDON}.git"
EGIT_BRANCH="${KODI_PVR_GIT_BRANCH:-master}"

DESCRIPTION="Kodi Isengard PVR Addon: DVBLink PVR"
HOMEPAGE="https://github.com/kodi-pvr/${ADDON}"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/kodi-platform
	dev-libs/tinyxml2
	!media-plugins/kodi-addon-pvrclients"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch_user

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)/kodi
		)

	cmake-utils_src_configure
}
