# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR plugin shared library: Generic OpenGL/ES OSD for VDR output plugins"
HOMEPAGE="https://github.com/lucianm/${PN}"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/lucianm/${PN}.git"
	KEYWORDS=""
	S="${WORKDIR}/${P}"
#else
#	SRC_URI="${P}.tgz"
#	KEYWORDS="~amd64 ~x86 ~arm"

fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug vaapi vdpau gles2"

DEPEND=">=media-video/vdr-2.2.0
	virtual/pkgconfig
	media-libs/freetype
	virtual/opengl
	media-libs/glew
	media-libs/freeglut
	media-libs/glm
	vaapi? ( x11-libs/libva )
	vdpau? ( x11-libs/libvdpau )
	gles2? ( media-libs/mesa[egl,gles2] )"

RDEPEND="${DEPEND}"

# for now, only vdpau works:
REQUIRED_USE="vdpau"

src_prepare() {
	vdr-plugin-2_src_prepare

	BUILD_PARAMS+=" OSD_DEBUG=$(usex debug 1 0)"
	BUILD_PARAMS+=" DEBUG_GL=$(usex debug 1 0)"
	BUILD_PARAMS+=" GLES2=$(usex gles2 1 0)"
}
