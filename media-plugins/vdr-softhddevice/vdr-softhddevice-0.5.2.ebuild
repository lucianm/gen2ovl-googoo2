# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit flag-o-matic toolchain-funcs vdr-plugin-2

VERSION="1108" # every bump, new version

DESCRIPTION="VDR Plugin: Software and GPU emulated HD output device"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-softhddevice"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
KEYWORDS="~amd64 ~x86"

LICENSE="AGPL-3"
SLOT="0"
IUSE="alsa oss vaapi vdpau yaepg"

DEPEND=">=media-video/vdr-1.7
		>=virtual/ffmpeg-0.7
		x11-libs/libX11
		>=x11-libs/libxcb-1.8
		x11-libs/xcb-util-wm
		x11-libs/xcb-util-keysyms
		x11-libs/xcb-util-renderutil
		virtual/pkgconfig
		alsa? ( media-libs/alsa-lib )
		vdpau? ( x11-libs/libvdpau
				virtual/ffmpeg[vdpau] )
		vaapi? ( x11-libs/libva
				virtual/ffmpeg[vaapi] )
		alsa? ( media-libs/alsa-lib )
		yaepg? ( >=media-video/vdr-1.7[yaepg] )"
RDEPEND="${DEPEND}
		x11-libs/xcb-util"

VDR_CONFD_FILE="${FILESDIR}/confd-0.5.2"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.5.2.sh"

src_compile() {
	append-cflags -DHAVE_PTHREAD_NAME
	append-cxxflags -DHAVE_PTHREAD_NAME
	tc-export CC CXX

	local myconf

	use vaapi && myconf="${myconf} -DUSE_VAAPI"
	use vdpau && myconf="${myconf} -DUSE_VDPAU"
	use alsa && myconf="${myconf} -DUSE_ALSA"
	use oss && myconf="${myconf} -DUSE_OSS"

	cd "${S}"

	BUILD_TARGETS=${BUILD_TARGETS:-${VDRPLUGIN_MAKE_TARGET:-all}}

	emake ${BUILD_PARAMS} CONFIG="${myconf}" \
		${BUILD_TARGETS} \
		LOCALEDIR="${TMP_LOCALE_DIR}" \
		LIBDIR="${S}" \
		TMPDIR="${T}" \
		|| die "emake failed"
}
