# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
SRC_URI=""

#GRAPHLCD_BASE_GIT_BRANCH="touchcol" 

: ${EGIT_REPO_URI:=${GRAPHLCD_BASE_GIT_REPO_URI:-git://projects.vdr-developer.org/graphlcd-base.git}}
: ${EGIT_BRANCH:=${GRAPHLCD_BASE_GIT_BRANCH:-master}}

inherit git-2 eutils flag-o-matic multilib

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://graphlcd.berlios.de/"
SRC_URI=""


KEYWORDS=""
SLOT="0"
LICENSE="GPL-2"
IUSE="debug driver_ax206_experimental driver_picolcd_256x64_experimental +fontconfig g15 graphicsmagick +imagemagick serdisplib +truetype vnc"
REQUIRED_USE="imagemagick? ( !graphicsmagick )"

DEPEND="truetype? ( media-libs/freetype )
	imagemagick? ( media-gfx/imagemagick )
	graphicsmagick? ( media-gfx/graphicsmagick )
	dev-libs/libxml2
	g15? ( app-misc/g15daemon )
	serdisplib? ( dev-libs/serdisplib )
	fontconfig? ( media-libs/fontconfig )
	vnc? ( net-libs/libvncserver )
"

RDEPEND="truetype? ( media-fonts/corefonts )"

src_prepare() {

	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:" || die "sed /usr/local path failed"

	sed -i "s:PRESTRIP:#PRESTRIP:" Make.config || die "sed PRESTRIP failed"

	epatch_user

	if use !truetype; then
		sed -i "s:HAVE_FREETYPE2:#HAVE_FREETYPE2:" Make.config || die "sed #HAVE_FREETYPE2 failed"
	fi

	if use !fontconfig; then
		sed -i "s:HAVE_FONTCONFIG:#HAVE_FONTCONFIG:" Make.config || die "sed #HAVE_FONTCONFIG failed"
	fi

	if use imagemagick; then
		sed -i "s:#HAVE_IMAGEMAGICK:HAVE_IMAGEMAGICK:" Make.config || die "sed HAVE_IMAGEMAGICK failed"
	fi

	if use graphicsmagick; then
		sed -i "s:#HAVE_GRAPHICSMAGICK:HAVE_GRAPHICSMAGICK:" Make.config || die "sed HAVE_GRAPHICSMAGICK failed"
		sed -i "s/^IMAGELIB\ =\s*$/IMAGELIB\ =\ imagemagick/" glcdgraphics/Makefile || die "sed IMAGELIB failed"
	fi

	if use driver_ax206_experimental; then
		sed -i "s:#HAVE_AX206DPF_EXPERIMENTAL:HAVE_AX206DPF_EXPERIMENTAL:" Make.config || die "sed HAVE_AX206DPF_EXPERIMENTAL failed"
	fi

	if use driver_picolcd_256x64_experimental; then
		sed -i "s:#HAVE_picoLCD_256x64_EXPERIMENTAL:HAVE_picoLCD_256x64_EXPERIMENTAL:" Make.config || die "sed HAVE_picoLCD_256x64_EXPERIMENTAL failed"
	fi

	if use !vnc; then
		sed -i "s:HAVE_DRIVER_VNCSERVER:#HAVE_DRIVER_VNCSERVER:" Make.config || die "sed #HAVE_DRIVER_VNCSERVER failed"
	fi

}

src_compile() {
	local BUILD_PARAMS=""
	use debug && BUILD_PARAMS="HAVE_DEBUG=1"
	emake $BUILD_PARAMS || die "emake failed"
}

src_install() {

	dodir /lib/udev/rules.d
	emake DESTDIR="${D}"usr LIBDIR="${D}"usr/$(get_libdir) UDEVRULESDIR="${D}"lib/udev/rules.d install

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*

}
