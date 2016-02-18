# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2 git-r3

SRC_URI=""

GRAPHLCD_BASE_GIT_BRANCH="touchcol" 

: ${EGIT_REPO_URI:=${GRAPHLCD_BASE_GIT_REPO_URI:-git://projects.vdr-developer.org/vdr-plugin-graphlcd.git}}
: ${EGIT_BRANCH:=${GRAPHLCD_BASE_GIT_BRANCH:-master}}

DESCRIPTION="VDR Graphical LCD Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/graphlcd"

KEYWORDS=""

SLOT="0"
LICENSE="GPL-2"
IUSE="debug"

DEPEND=">=media-video/vdr-1.6
	>=app-misc/graphlcd-base-9999"
RDEPEND="${DEPEND}
	media-fonts/vdrsymbols-ttf"

S="${WORKDIR}/${P}"

#PATCHES="${FILESDIR}/graphlcd-9999_Makefile-vdr-1.7.34.diff"

pkg_setup() {
	vdr-plugin-2_pkg_setup

	if ! getent group lp | grep -q vdr; then
		echo
		einfo "Add user 'vdr' to group 'lp' for full user access to parport device"
		echo
		elog "User vdr added to group lp"
		gpasswd -a vdr lp
	fi
	if ! getent group usb | grep -q vdr; then
		echo
		einfo "Add user 'vdr' to group 'usb' for full user access to usb device"
		echo
		elog "User vdr added to group usb"
		gpasswd -a vdr usb
	fi
}

src_install() {
	# let the Makefile install everything but TTF and docs by itself
	SKIP_INSTALL_TTF=1 SKIP_INSTALL_DOC=1 vdr-plugin-2_src_install

	insopts -m0644 -ovdr -gvdr

	# some vdr versions, like 1.7.33 have resdir=/etc/vdr set in vdr.pc...
	local myresdir="$(pkg-config --variable=resdir vdr)"
	# while others do not set it at all, for those we will hard-code to /usr/share/vdr
	[[ -z "${myresdir}" ]] && myresdir="/usr/share/vdr"

	# symlink our own TTF, since we skipped installing them from the package
	for font in /usr/share/fonts/corefonts/*.ttf; do
		elog ${font}
		dosym ${font} ${myresdir}/plugins/${VDRPLUGIN}/fonts
	done

	dosym /usr/share/fonts/ttf-bitstream-vera/VeraBd.ttf ${myresdir}/plugins/${VDRPLUGIN}/fonts/VeraBd.ttf
	dosym /usr/share/fonts/ttf-bitstream-vera/Vera.ttf ${myresdir}/plugins/${VDRPLUGIN}/fonts/Vera.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSansCondensed.ttf ${myresdir}/plugins/${VDRPLUGIN}/fonts/DejaVuSansCondensed.ttf
	dosym /usr/share/fonts/vdrsymbols-ttf/VDRSymbolsSans.ttf ${myresdir}/plugins/${VDRPLUGIN}/fonts/VDRSymbolsSans.ttf

	# symlink default hardware config file
	insinto /etc/vdr/plugins/${VDRPLUGIN}
	dosym /etc/graphlcd.conf /etc/vdr/plugins/${VDRPLUGIN}/graphlcd.conf
}

pkg_preinst() {
	if [[ -e /etc/vdr/plugins/graphlcd/fonts ]] && [[ ! -L /etc/vdr/plugins/graphlcd/fonts ]] \
	|| [[ -e /etc/vdr/plugins/graphlcd/logos ]] && [[ ! -L /etc/vdr/plugins/graphlcd/logos ]] ;then

		elog "Remove wrong DIR in /etc/vdr/plugins/graphlcd from prior install"
		elog "Press CTRL+C to abbort"
		epause
		rmdir -R /etc/vdr/plugins/graphlcd/{fonts,logos}
	fi
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	elog "Add additional options in /etc/conf.d/vdr.graphlcd"
}

