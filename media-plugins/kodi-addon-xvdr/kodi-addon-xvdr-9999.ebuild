# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2 autotools multilib eutils

EGIT_REPO_URI="git://github.com/pipelka/xbmc-addon-xvdr.git"

DESCRIPTION="XBMC addon: add VDR (http://www.cadsoft.de/vdr) as a TV/PVR Backend"
HOMEPAGE="https://github.com/pipelka/xbmc-addon-xvdr"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

RDEPEND=">=media-tv/kodi-13.9"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch_user
	eautoreconf
}

src_configure() {
	econf --prefix=/usr/share/kodi
}

src_install() {
	emake DESTDIR="${D}" install
	dodir "/usr/$(get_libdir)/kodi/addons/pvr.vdr.xvdr"
	mv "${D}usr/share/kodi/addons/pvr.vdr.xvdr/XBMC_VDR_xvdr.pvr" \
		"${D}usr/$(get_libdir)/kodi/addons/pvr.vdr.xvdr" || \
		die "Could not move the addon shared object to the actual LIBDIR"
}

pkg_info() {
	einfo "This add-on requires the "media-lugins/vdr-xvdr" plugin on the VDR server"
	einfo "(or similar, depending on the distribution used on the VDR backend machine)"
	einfo "VDR itself doesn't need any patches or modification to use all the current features."
	einfo "IMPORTANT:"
	einfo "Please disable *all* PVR addons *before* running the XVDR addon!"
}
