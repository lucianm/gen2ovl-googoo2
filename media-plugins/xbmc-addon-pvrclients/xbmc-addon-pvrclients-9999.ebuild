# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit git-2 autotools multilib eutils

EGIT_REPO_URI="${PVRADDONS_EGIT_REPO_URI:-git://github.com/FernetMenta/xbmc-pvr-addons.git}"
EGIT_PROJECT="xbmc-pvr-addons${PVRADDONS_EGIT_PROJECT:-}.git"
EGIT_BRANCH="${PVRADDONS_EGIT_BRANCH:-master}"

DESCRIPTION="XBMC Frodo PVR Addons"
HOMEPAGE="https://github.com/FernetMenta/xbmc-pvr-addons"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"

PVRCLIENTS="argustv demo dvbviewer tvheadend mediaportal mythtv nextpvr njoy vnsi vuplus"
for pvrclient in ${PVRCLIENTS}; do
	IUSE_PVRCLIENTS+=" pvrclient_${pvrclient}"
done
IUSE="${IUSE_PVRCLIENTS}"
REQUIRED_USE="|| ( ${IUSE_PVRCLIENTS} )"

RDEPEND=">=media-tv/xbmc-12.0"

DEPEND="${RDEPEND}
	pvrclient_mythtv? ( virtual/mysql
		dev-libs/boost )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch_user

	use pvrclient_argustv || sed -i "s:pvr.argustv::" addons/Makefile.am
	use pvrclient_demo || sed -i "s:pvr.demo::" addons/Makefile.am
	use pvrclient_dvbviewer || sed -i "s:pvr.dvbviewer::" addons/Makefile.am
	if ! use pvrclient_tvheadend; then
		sed -i "s:pvr.hts::" addons/Makefile.am
		sed -i "s: libhts::" lib/Makefile.am
	fi
	use pvrclient_mediaportal || sed -i "s:pvr.mediaportal.tvserver::" addons/Makefile.am
	use pvrclient_nextpvr || sed -i "s:pvr.nextpvr::" addons/Makefile.am
	use pvrclient_njoy || sed -i "s:pvr.njoy::" addons/Makefile.am
	use pvrclient_vnsi || sed -i "s:pvr.vdr.vnsi::" addons/Makefile.am
	use pvrclient_vuplus || sed -i "s:pvr.vuplus::" addons/Makefile.am
	if ! use pvrclient_vuplus && ! use pvrclient_nextpvr && ! use pvrclient_njoy && ! use pvrclient_demo && ! use pvrclient_mediaportal; then
		sed -i "s: tinyxml::" lib/Makefile.am
	fi
	if ! use pvrclient_argustv; then
		sed -i "s: jsoncpp::" lib/Makefile.am
	fi

	eautoreconf
}

src_configure() {
	econf --prefix=/usr \
		--libdir=/usr/$(get_libdir)/xbmc/addons \
		--datadir=/usr/share/xbmc/addons \
		$(use_enable pvrclient_mythtv addons-with-dependencies)
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_info() {
	einfo "The VNSI PVR client requires "media-lugins/vdr-vnsiserver" plugin on the VDR server."
	einfo "(or similar, depending on the distribution used on the VDR server machine)."
	einfo "VDR itself doesn't need any patches or modification to use all the current features."
	einfo "IMPORTANT:"
	einfo "Please disable *all* PVR addons *before* running the VNSI addon!"
	einfo "Of course, if using another PVR client than VNSI, another TV backend than VDR is required"
}
