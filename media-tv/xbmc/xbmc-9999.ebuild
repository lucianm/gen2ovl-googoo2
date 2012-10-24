# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

# Does not work with py3 here
# It might work with py:2.5 but I didn't test that
PYTHON_DEPEND="2:2.6"

inherit eutils python

EGIT_REPO_URI=${XBMC_EGIT_REPO_URI:-git://github.com/xbmc/xbmc.git}
if [[ ${PV} == "9999" ]] ; then
	inherit git-2 autotools
else
	inherit autotools
	MY_P=${P/_/-*_}
	SRC_URI="http://mirrors.xbmc.org/releases/source/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="XBMC is a free and open source media-player and entertainment hub"
HOMEPAGE="http://xbmc.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="airplay alsa altivec avahi bluetooth bluray cec css debug goom joystick midi mysql nfs profile +projectm pulseaudio pvr +rsxs rtmp +samba sse sse2 sftp udev upnp vaapi vdpau webserver +xrandr"
REQUIRED_USE="pvr? ( mysql )"

COMMON_DEPEND="virtual/opengl
	app-arch/bzip2
	app-arch/unzip
	app-arch/zip
	app-i18n/enca
	airplay? ( app-pda/libplist )
	>=dev-lang/python-2.4
	dev-libs/boost
	dev-libs/fribidi
	dev-libs/libcdio[-minimal]
	cec? ( dev-libs/libcec )
	dev-libs/libpcre[cxx]
	>=dev-libs/lzo-2.04
	dev-libs/tinyxml
	dev-libs/yajl
	>=dev-python/pysqlite-2
	dev-python/simplejson
	media-libs/alsa-lib
	media-libs/flac
	media-libs/fontconfig
	media-libs/freetype
	>=media-libs/glew-1.5.6
	media-libs/jasper
	media-libs/jbigkit
	>=media-libs/libass-0.9.7
	bluray? ( media-libs/libbluray )
	css? ( media-libs/libdvdcss )
	media-libs/libmad
	media-libs/libmodplug
	media-libs/libmpeg2
	media-libs/libogg
	media-libs/libpng
	projectm? ( media-libs/libprojectm )
	media-libs/libsamplerate
	media-libs/libsdl[audio,opengl,video,X]
	alsa? ( media-libs/libsdl[alsa] )
	>=media-libs/taglib-1.8
	media-libs/libvorbis
	media-libs/sdl-gfx
	>=media-libs/sdl-image-1.2.10[gif,jpeg,png]
	media-libs/sdl-mixer
	media-libs/sdl-sound
	media-libs/tiff
	pulseaudio? ( media-sound/pulseaudio )
	media-sound/wavpack
	|| ( media-libs/libpostproc <media-video/libav-0.8.2-r1 media-video/ffmpeg )
	>=virtual/ffmpeg-0.6[encode]
	rtmp? ( media-video/rtmpdump )
	avahi? ( net-dns/avahi )
	nfs? ( net-fs/libnfs )
	webserver? ( net-libs/libmicrohttpd )
	sftp? ( net-libs/libssh )
	net-misc/curl
	samba? ( >=net-fs/samba-3.4.6[smbclient] )
	bluetooth? ( net-wireless/bluez )
	sys-apps/dbus
	sys-libs/zlib
	virtual/jpeg
	mysql? ( virtual/mysql )
	x11-apps/xdpyinfo
	x11-apps/mesa-progs
	vaapi? ( x11-libs/libva[opengl] )
	vdpau? (
		|| ( x11-libs/libvdpau >=x11-drivers/nvidia-drivers-180.51 )
		virtual/ffmpeg[vdpau]
	)
	x11-libs/libXinerama
	xrandr? ( x11-libs/libXrandr )
	x11-libs/libXrender"
RDEPEND="${COMMON_DEPEND}
	udev? (	sys-fs/udisks:0 sys-power/upower )"
DEPEND="${COMMON_DEPEND}
	dev-util/gperf
	x11-proto/xineramaproto
	dev-util/cmake
	dev-lang/swig
	x86? ( dev-lang/nasm )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
		cd "${S}"
		rm -f configure
	else
		unpack ${A}
		cd "${S}"
	fi

	# Fix case sensitivity
	mv media/Fonts/{a,A}rial.ttf || die
	mv media/{S,s}plash.png || die
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-9999-nomythtv.patch
	epatch "${FILESDIR}"/${PN}-9999-no-arm-flags.patch #400617
	# The mythtv patch touches configure.ac, so force a regen
	rm -f configure

	# some dirs ship generated autotools, some dont
	local d
	for d in \
		. \
		lib/{libdvd/lib*/,cpluff} \
		xbmc/screensavers/rsxs-* \
		xbmc/visualizations/Goom/goom2k4-0
	do
		[[ -e ${d}/configure ]] && continue
		pushd ${d} >/dev/null
		eautoreconf
		popd >/dev/null
	done

	# Disable internal func checks as our USE/DEPEND
	# stuff handles this just fine already #408395
	export ac_cv_lib_avcodec_ff_vdpau_vc1_decode_picture=yes

	local squish #290564
	use altivec && squish="-DSQUISH_USE_ALTIVEC=1 -maltivec"
	use sse && squish="-DSQUISH_USE_SSE=1 -msse"
	use sse2 && squish="-DSQUISH_USE_SSE=2 -msse2"
	sed -i \
		-e '/^CXXFLAGS/{s:-D[^=]*=.::;s:-m[[:alnum:]]*::}' \
		-e "1iCXXFLAGS += ${squish}" \
		lib/libsquish/Makefile.in || die

	# Fix XBMC's final version string showing as "exported"
	# instead of the SVN revision number.
	export HAVE_GIT=no GIT_REV=${EGIT_VERSION:-exported}

	# avoid long delays when powerkit isn't running #348580
	sed -i \
		-e '/dbus_connection_send_with_reply_and_block/s:-1:3000:' \
		xbmc/linux/*.cpp || die

	epatch_user #293109

	# Tweak autotool timestamps to avoid regeneration
	find . -type f -print0 | xargs -0 touch -r configure
}

src_configure() {
	# Disable documentation generation
	export ac_cv_path_LATEX=no
	# Avoid help2man
	export HELP2MAN=$(type -P help2man || echo true)
	# No configure flage for this #403561
	export ac_cv_lib_bluetooth_hci_devid=$(usex bluetooth)

	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-ccache \
		--disable-optimizations \
		--enable-external-libraries \
		--enable-external-ffmpeg \
		--enable-gl \
		$(use_enable airplay) \
		$(use_enable avahi) \
		$(use_enable bluray libbluray) \
		$(use_enable cec libcec) \
		$(use_enable css dvdcss) \
		$(use_enable debug) \
		$(use_enable goom) \
		--disable-hal \
		$(use_enable joystick) \
		$(use_enable midi mid) \
		$(use_enable mysql) \
		$(use_enable nfs) \
		$(use_enable profile profiling) \
		$(use_enable projectm) \
		$(use_enable pulseaudio pulse) \
		$(use_enable pvr mythtv) \
		$(use_enable rsxs) \
		$(use_enable rtmp) \
		$(use_enable samba) \
		$(use_enable sftp ssh) \
		$(use_enable upnp) \
		$(use_enable vaapi) \
		$(use_enable vdpau) \
		$(use_enable webserver) \
		$(use_enable xrandr)
}

src_install() {
	default
	rm "${ED}"/usr/share/doc/*/{LICENSE.GPL,copying.txt}*

	domenu tools/Linux/xbmc.desktop
	newicon tools/Linux/xbmc-48x48.png xbmc.png

	insinto "$(python_get_sitedir)" #309885
	doins tools/EventClients/lib/python/xbmcclient.py || die
	newbin "tools/EventClients/Clients/XBMC Send/xbmc-send.py" xbmc-send || die
}

pkg_postinst() {
	elog "Visit http://wiki.xbmc.org/?title=XBMC_Online_Manual"
}
