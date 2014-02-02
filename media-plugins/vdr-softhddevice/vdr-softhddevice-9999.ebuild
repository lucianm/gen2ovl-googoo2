# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit vdr-plugin-2

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
IUSE="alsa +debug opengl oss vaapi vdpau xscreensaver"

RESTRICT="test"

RDEPEND=">=media-video/vdr-2
	x11-libs/libX11
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	vaapi? ( x11-libs/libva
		virtual/ffmpeg[vaapi] )
	vdpau? ( x11-libs/libvdpau
		virtual/ffmpeg[vdpau] )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-libs/xcb-util"

REQUIRED_USE="opengl? ( vaapi )
			|| ( vaapi vdpau )
			|| ( alsa oss )"

VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

pkg_setup() {
	vdr-plugin-2_pkg_setup

	append-cppflags -DHAVE_PTHREAD_NAME
 
	use debug && append-cppflags -DDEBUG -DOSD_DEBUG
}

src_prepare() {
	vdr-plugin-2_src_prepare

	if has_version ">=media-video/ffmpeg-2.0"; then
		sed -i "s:#CONFIG += -DH264_EOS_TRICKSPEED:CONFIG += -DH264_EOS_TRICKSPEED:" Makefile || die
	fi
	BUILD_PARAMS+=" ALSA=$(usex alsa 1 0)"
	BUILD_PARAMS+=" OPENGL=$(usex opengl 1 0)"
	BUILD_PARAMS+=" OSS=$(usex oss 1 0)"
	BUILD_PARAMS+=" VAAPI=$(usex vaapi 1 0)"
	BUILD_PARAMS+=" VDPAU=$(usex vdpau 1 0)"
	BUILD_PARAMS+=" SCREENSAVER=$(usex xscreensaver 1 0)"

	if has_version ">=media-video/ffmpeg-0.8"; then
		BUILD_PARAMS+=" SWRESAMPLE=1"
	fi
}

src_install() {
	vdr-plugin-2_src_install

	nonfatal dodoc ChangeLog Todo
}
