# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2

VERSION="1117" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/skin-nopacity.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - \"nOpacity\" - hightly customizable native TrueColor Skin"
HOMEPAGE="http://projects.vdr-developer.org/projects/skin-nopacity"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.28
	media-gfx/imagemagick"
RDEPEND="${DEPEND}
	virtual/channel-logos-hq"

#VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
#VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/themes
	doins "${S}"/themes/*.theme

	insinto /usr/share/vdr/${VDRPLUGIN}
	doins -r icons

	chown vdr:vdr -R "${D}"/etc/vdr
}

pkg_postinst() {
	einfo "Please check and ajust your settings in \"/etc/conf.d/vdr.${VDRPLUGIN}\","
	einfo "especially for the channel logos path, and in general, make sure"
	einfo "they end with an \"/\""
}

#src_compile() {
#	local myconf

#	myconf+=" ALSA=$(usex alsa 1 0)"
#	myconf+=" JPEG=$(usex jpeg 1 0)"
#	#myconf+=" GLX=$(usex opengl 1 0)"
#	myconf+=" GLX=0"
#	myconf+=" OSS=$(usex oss 1 0)"
#	myconf+=" VAAPI=$(usex vaapi 1 0)"
#	myconf+=" VDPAU=$(usex vdpau 1 0)"
#	myconf+=" YAEPG=$(usex yaepg 1 0)"
#	myconf+=" TS_VIDEO=$(usex ts_video 1 0)"
#	myconf+=" SCREENSAVER=$(usex xscreensaver 1 0)" # FIXME: screensaver is currently always enabled

#	append-cflags -DHAVE_PTHREAD_NAME
#	append-cxxflags -DHAVE_PTHREAD_NAME
#	tc-export CC CXX

#	emake all LIBDIR="." $myconf || die "emake failed"
#}
