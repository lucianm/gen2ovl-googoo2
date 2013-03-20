# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit flag-o-matic toolchain-funcs vdr-plugin-2

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
IUSE="alsa oss vaapi vdpau +xscreensaver"

RDEPEND=">=media-video/vdr-1.7.39
	>=virtual/ffmpeg-0.7
	x11-libs/libX11
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	alsa? ( media-libs/alsa-lib )
	vdpau? ( x11-libs/libvdpau
			virtual/ffmpeg[vdpau] )
	vaapi? ( x11-libs/libva
			virtual/ffmpeg[vaapi] )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-libs/xcb-util"

VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

src_prepare() {
	vdr-plugin-2_src_prepare

	BUILD_PARAMS+=" ALSA=$(usex alsa 1 0)"
	BUILD_PARAMS+=" OSS=$(usex oss 1 0)"
	BUILD_PARAMS+=" VAAPI=$(usex vaapi 1 0)"
	BUILD_PARAMS+=" VDPAU=$(usex vdpau 1 0)"
	BUILD_PARAMS+=" SCREENSAVER=$(usex xscreensaver 1 0)"
}

src_install() {
	vdr-plugin-2_src_install

	dodoc ChangeLog Todo
}
