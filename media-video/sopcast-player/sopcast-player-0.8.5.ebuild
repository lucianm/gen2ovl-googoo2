# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A GTK+ front-end for the SopCast P2P TV player"
HOMEPAGE="http://code.google.com/p/sopcast-player/"
SRC_URI="http://sopcast-player.googlecode.com/files/${P}.tar.gz"

LICENSE=""
SLOT="unstable"
KEYWORDS="~amd64 ~x86"
IUSE="totem +vlc gnome-mplayer"

DEPEND="totem? ( >=media-video/totem-2.32.0-r2  )
	gnome-mplayer? ( >=media-video/gnome-mplayer-1.0.5_beta1 )
	vlc? ( >media-video/vlc-1.10 )
	dev-lang/python[sqlite]
	sys-devel/gettext"
	
RDEPEND="${DEPEND}
	dev-python/pygtk
	dev-python/pygobject
	net-p2p/sopcast-bin"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i "s:;P2P;:;P2P;Network;:" "${PN}".desktop || die "Failed to sed the .desktop file with the Network category"
}

src_install() {
	einstall DESTDIR="${D}"
	cd "${WORKDIR}"
	elog "For any problems email to Jason Scheunemann at flyguy97@gmail.com or Pietro Acinapura at pietro.ac@gmail.com for Gentoo ebuild!"
	echo
}
