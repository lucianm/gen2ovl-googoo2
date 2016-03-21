# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils


if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-skindesigner.git"
	KEYWORDS=""
	S="${WORKDIR}/${P}/${PN}"
else
	MY_PV="0.9.1"
	SRC_URI="http://projects.vdr-developer.org/git/vdr-plugin-skindesigner.git/snapshot/vdr-plugin-skindesigner-${MY_PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vdr-plugin-skindesigner-${MY_PV}/${PN}"
fi

DESCRIPTION="Video Disk Recorder - API library exporting \"skindesigner\" functionality to other plugins"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-skindesigner"

SLOT="0"
LICENSE="GPL-2 Apache-2.0"
IUSE=""

DEPEND=">=media-video/vdr-2.0.0"

	
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}_LIBDIR-assignable_SO-symlink.patch" || die
}

#src_compile() {
#	LCLBLD="1" emake || die
#}

src_install() {
	PREFIX="/usr" LIBDIR="${PREFIX}/$(get_libdir)" DESTDIR="${D}" einstall || die
}
