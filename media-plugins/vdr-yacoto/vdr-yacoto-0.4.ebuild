# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: Yacoto - Yet Another Convert Tool"
HOMEPAGE="http://redmine.gen2vdr.org/projects/vdr-plugin-${VDRPLUGIN}"
SRC_URI="http://redmine.gen2vdr.org/attachments/147/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="3gp +dvd ipod mp3 ogg +projectx +status +x264 +xvid"

DEPEND=">=media-video/vdr-1.7.15
	!media-video/yacoto-scripts"

RDEPEND="${DEPEND}
	media-video/vdrsync
	app-misc/screen
	>=media-video/replex-0.1.6.8
	3gp? (	media-video/mplayer[encode]
		virtual/ffmpeg[encode] )
	dvd? (	app-cdr/cdrtools
		app-cdr/dvd+rw-tools
		media-video/vamps
		media-video/mjpegtools
		media-gfx/imagemagick
		media-video/dvdauthor )
	ipod? (	media-video/mplayer[encode]
		virtual/ffmpeg[encode]
		media-video/gpac )
	mp3? (	media-sound/lame )
	ogg? (	media-sound/lame
		media-sound/vorbis-tools )
	projectx? ( media-video/projectx )
	status? ( media-plugins/vdr-bgprocess )
	x264? (	media-video/mplayer[encode,x264=] )
	xvid? ( || (	media-video/mplayer[encode,xvid=]
			virtual/ffmpeg[encode,xvid=] ) )"

MY_YAC_CONF_DIR="/etc/vdr/plugins/yacoto"
MY_YAC_DIR="/usr/share/vdr/yacoto"

PATCHES="
	${FILESDIR}/${P}_quotes.diff
	${FILESDIR}/${P}_DirOrderState.diff
	${FILESDIR}/${P}_tilde-in-path.diff
	${FILESDIR}/${P}_projectx.diff
"

src_prepare() {
	if has_version ">=media-video/vdr-1.7.23"; then
		epatch "${FILESDIR}/${P}_svdrpsend_vdr-1.7.23.diff"
	fi
	if has_version ">=media-video/vdr-1.7.27"; then
		epatch "${FILESDIR}/${P}_vdr-1.7.27.diff"
	fi

	vdr-plugin-2_src_prepare

	# copy script conf files into sandbox for i18n generation
	mkdir -p "${WORKDIR}"/yacoto/conf
	cp ${MY_YAC_CONF_DIR}/ya*conf* "${WORKDIR}"/yacoto
	cp ${MY_YAC_DIR}/ya*conf* "${WORKDIR}"/yacoto
	cp ${MY_YAC_CONF_DIR}/conf/*.conf "${WORKDIR}"/yacoto/conf
}

src_compile() {
	# build only the plugin without i18n first, with proper YAC_CONF_DIR
	BUILD_TARGETS="libvdr-${VDRPLUGIN}.so" YAC_DIR="${MY_YAC_DIR}" vdr-plugin-2_src_compile

	# now build i18n, with faked YAC_CONF_DIR
	BUILD_TARGETS="i18n" YAC_CONF_DIR="${WORKDIR}"/yacoto vdr-plugin-2_src_compile
}

src_install() {

	keepdir ${MY_YAC_DIR}/queue
	keepdir /var/log/yacoto

	S="${WORKDIR}/${VDRPLUGIN}-${PV}"
	vdr-plugin-2_src_install

	dodoc README.en TODO

	S="${WORKDIR}/${VDRPLUGIN}-${PV}/${VDRPLUGIN}"
	cd "${S}"
	# internal variables controlling optional encoding profiles are set default to "1",
	# so if we do not want them, set them here to "0" before invoking the install rule
	use 3gp || OPTIONS+="WITH_3GP=0"
	use dvd || OPTIONS+=" WITH_DVD=0"
	use ipod || OPTIONS+=" WITH_IPOD=0"
	use mp3 || OPTIONS+=" WITH_MP3=0"
	use ogg || OPTIONS+=" WITH_OGG=0"
	use projectx || OPTIONS+=" WITH_PROJECTX=0"
	use x264 || OPTIONS+=" WITH_H264=0"
	use xvid || OPTIONS+=" WITH_DIVX=0"

	DESTDIR="${D}" YAC_DIR="${MY_YAC_DIR}" eval "${OPTIONS}" emake install || die "Installation of yacoto scripts failed!"

	cd "${D}${MY_YAC_CONF_DIR}"
	rename .conf.sample .conf *.conf.sample
	cd "${D}${MY_YAC_CONF_DIR}"/conf
	rename .conf.sample .conf *.conf.sample
	if use dvd; then
		cd "${D}${MY_YAC_CONF_DIR}"/conf/dvd
		rename .conf.sample .conf *.conf.sample
	fi

}

pkg_postinst(){

	ewarn ""
	ewarn "If this is your first installation, please make sure"
	ewarn "you create an initial vdr-yacoto plugin configuration"
	ewarn "file before starting VDR!"
	ewarn ""
	ewarn "This file, located at \"${MY_YAC_CONF_DIR}/yacadmin.conf\""
	ewarn "can be generated by running"
	ewarn "\"${MY_YAC_DIR}/yac_setplgconf.sh\" after adjusting"
	ewarn "the values in \"${MY_YAC_CONF_DIR}/yacoto.conf\"."
	ewarn ""
	ewarn "You can also adjust some variables in"
	ewarn "\"${MY_YAC_CONF_DIR}/myvars.conf\"..."
	if use projectx; then
		ewarn "...and \"${MY_YAC_CONF_DIR}/conf/ProjectX.ini\"..."
	fi
	ewarn ""
	epause 5

}
