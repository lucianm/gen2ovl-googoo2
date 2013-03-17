# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit flag-o-matic toolchain-funcs vdr-plugin-2 eutils

VERSION="1309" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-softhddevice.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="VDR Plugin: Software and GPU emulated HD output device"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-softhddevice"

LICENSE="AGPL-3"
SLOT="0"
IUSE="alsa debug oss vaapi vdpau yaepg xscreensaver"
# opengl, not supported in sources yet

RDEPEND=">=media-video/vdr-1.7
	>=virtual/ffmpeg-0.7[vdpau?,vaapi?]
	x11-libs/libX11
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util-wm
	alsa? ( media-libs/alsa-lib )
	vdpau? ( x11-libs/libvdpau )
	vaapi? ( x11-libs/libva )
	alsa? ( media-libs/alsa-lib )
	yaepg? ( >=media-video/vdr-1.7[yaepg] )"
DEPEND="${RDEPEND}
	x11-libs/xcb-util
	sys-devel/gettext
	virtual/pkgconfig
	oss? ( sys-kernel/linux-headers )"

VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

src_compile() {
	local myconf

	myconf+=" ALSA=$(usex alsa 1 0)"
	myconf+=" OSS=$(usex oss 1 0)"
	myconf+=" VDPAU=$(usex vdpau 1 0)"
	myconf+=" VAAPI=$(usex vaapi 1 0)"
	myconf+=" SCREENSAVER=$(usex xscreensaver 1 0)"
	if has_version ">=media-video/ffmpeg-0.8" ; then
		myconf+=" SWRESAMPLE=1"
	fi

	append-cflags -DHAVE_PTHREAD_NAME
	append-cxxflags -DHAVE_PTHREAD_NAME
	tc-export CC CXX

	BUILD_PARAMS="${myconf}"
	vdr-plugin-2_src_compile
}

src_install() {
	vdr-plugin-2_src_install
	dodoc ChangeLog
}
