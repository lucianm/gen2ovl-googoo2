# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit flag-o-matic toolchain-funcs vdr-plugin eutils

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-softhddevice.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/889/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Software and GPU emulated HD output device plugin for VDR"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-softhddevice"

LICENSE="AGPL-3"
SLOT="0"
IUSE="alsa jpeg opengl oss vaapi vdpau yaepg xscreensaver"

RDEPEND=">=media-video/vdr-1.7
	>=virtual/ffmpeg-0.7
	x11-libs/libX11
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util-wm
	opengl? ( virtual/opengl )
	alsa? ( media-libs/alsa-lib )
	vdpau? ( x11-libs/libvdpau )
	vaapi? ( x11-libs/libva[opengl?] )
	alsa? ( media-libs/alsa-lib )
	yaepg? ( >=media-video/vdr-1.7[yaepg] )"
DEPEND="${RDEPEND}
	x11-libs/xcb-util
	sys-devel/gettext
	virtual/pkgconfig
	oss? ( sys-kernel/linux-headers )
	jpeg? ( virtual/jpeg )"

src_prepare() {
	vdr-plugin_src_prepare

	#epatch "${FILESDIR}/${P}-Makefile.patch"
}

src_compile() {
	local myconf

	myconf+=" ALSA=$(usex alsa 1 0)"
	myconf+=" JPEG=$(usex jpeg 1 0)"
	myconf+=" GLX=$(usex opengl 1 0)"
	myconf+=" OSS=$(usex oss 1 0)"
	myconf+=" VAAPI=$(usex vaapi 1 0)"
	myconf+=" VDPAU=$(usex vdpau 1 0)"
	myconf+=" YAEPG=$(usex yaepg 1 0)"
	myconf+=" SCREENSAVER=$(usex xscreensaver 1 0)" # FIXME: screensaver is currently always enabled

	append-cflags -DHAVE_PTHREAD_NAME
	append-cxxflags -DHAVE_PTHREAD_NAME
	tc-export CC CXX

	emake all LIBDIR="." $myconf || die
}

src_install() {
	vdr-plugin_src_install

	dodoc ChangeLog
}
