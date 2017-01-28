# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vdr-plugin-2

KEYWORDS="~amd64 ~x86"

case ${PV} in
9999)
#	if use opengl; then
		EGIT_REPO_URI="https://github.com/lucianm/softhddevice-unified.git"
		#EGIT_REPO_URI="https://github.com/lucianm/vdr-plugin-softhddevice.git"
#	else
		#EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
#		EGIT_REPO_URI="https://github.com/pesintta/vdr-plugin-${VDRPLUGIN}.git"
#		EGIT_BRANCH="vpp_support"
#	fi
	inherit git-r3
	KEYWORDS=""
	S="${WORKDIR}/vdr-${VDRPLUGIN}-${PV}"
	;;
0.6.1_p20151001)
	GIT_REVISION="5dc5601576c617516ec41c9c4899d3e18c0cc030"
	SRC_URI="http://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git/snapshot/vdr-plugin-${VDRPLUGIN}-${GIT_REVISION}.tar.bz2"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${GIT_REVISION}"
	;;
0.6.1_p20151103)
	GIT_REVISION="6dfa88aecf1b5a4c5932ba278209d9f22676547f"
	SRC_URI="http://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git/snapshot/vdr-plugin-${VDRPLUGIN}-${GIT_REVISION}.tar.bz2"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${GIT_REVISION}"
	;;
0.6.0)
	VERSION="1309" # every bump, new version
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	;;
*)
	;;
esac

DESCRIPTION="VDR Plugin: Software and GPU emulated HD output device"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${VDRPLUGIN}"

LICENSE="AGPL-3"
SLOT="0"
IUSE="alsa debug gles2 opengl openglosd oss vaapi vdpau -xscreensaver"

#RESTRICT="test"

RDEPEND=">=media-video/vdr-2
	x11-libs/libX11
	>=x11-libs/libxcb-1.8
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl
			media-libs/glu
			media-libs/mesa
			media-plugins/vdr-psl-oglosd )
	vaapi? ( x11-libs/libva
			virtual/ffmpeg[vaapi] )
	vdpau? ( x11-libs/libvdpau
			virtual/ffmpeg[vdpau] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-libs/xcb-util"

REQUIRED_USE="opengl? ( || ( vaapi vdpau ) )
	|| ( alsa oss )"

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
	sed -i "s:#CONFIG += -DHAVE_PTHREAD_NAME:CONFIG += -DHAVE_PTHREAD_NAME:" Makefile || die
	BUILD_PARAMS+=" ALSA=$(usex alsa 1 0)"
	BUILD_PARAMS+=" OPENGL=$(usex opengl 1 0)"
	BUILD_PARAMS+=" GLES2=$(usex gles2 1 0)"
	use opengl && sed -i "s:#OPENGLOSD ?= 1:OPENGLOSD ?= 1:" Makefile || die
	BUILD_PARAMS+=" OPENGLOSD=$(usex openglosd 1 0)"
	BUILD_PARAMS+=" OSS=$(usex oss 1 0)"
	BUILD_PARAMS+=" VAAPI=$(usex vaapi 1 0)"
	BUILD_PARAMS+=" VDPAU=$(usex vdpau 1 0)"
	BUILD_PARAMS+=" SCREENSAVER=$(usex xscreensaver 1 0)"

	if has_version ">=media-video/ffmpeg-0.8"; then
		BUILD_PARAMS+=" SWRESAMPLE=1"
	fi

	if has_version ">=media-video/libav-0.8"; then
		BUILD_PARAMS+=" AVRESAMPLE=1"
	fi
}

src_install() {
	vdr-plugin-2_src_install

	nonfatal dodoc ChangeLog Todo
}

