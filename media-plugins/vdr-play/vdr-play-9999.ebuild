# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit flag-o-matic toolchain-funcs vdr-plugin-2 eutils

if [ ${PV} == "9999" ] ; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-play.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/1043/${P}.tgz"
	KEYWORDS="~x86 ~amd64"
fi

DESCRIPTION="A mediaplayer plugin for VDR."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-play"

LICENSE="AGPL-3"
SLOT="0"
IUSE="jpeg png ffmpeg"
# avfs isn'nt working, according to Johns' comment in the Makefile

RDEPEND=">=media-video/vdr-1.7
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	|| ( media-video/mplayer media-video/mplayer2 )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	ffmpeg? ( >=virtual/ffmpeg-0.7 )"
#	avfs? ( sys-fs/avfs )

DEPEND="${RDEPEND}
	x11-proto/xproto
	sys-devel/gettext
	dev-util/pkgconfig
	sys-devel/make"


src_compile() {
	local myconf

	myconf+=" JPG=$(usex jpeg 1 0)"
	myconf+=" PNG=$(usex png 1 0)"
#	myconf+=" AVFS=$(usex avfs 1 0)"
	myconf+=" SWSCALE=$(usex ffmpeg 1 0)"

	append-cflags -DHAVE_PTHREAD_NAME
	append-cxxflags -DHAVE_PTHREAD_NAME
	tc-export CC CXX

	BUILD_PARAMS="${myconf}"
	vdr-plugin-2_src_install
}

src_install() {
	vdr-plugin-2_src_install

	# README.* is installed already
	dodoc ChangeLog TODO.txt
}
