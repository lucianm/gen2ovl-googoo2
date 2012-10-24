# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit eutils vdr-plugin

EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"

inherit git

# weird version and paths stuff, for version bumps we have
# to modify REV_DIR
REV_DIR="310"
S="${WORKDIR}/${VDRPLUGIN}-${PV}/plugin"

DESCRIPTION="MarkAd marks advertisments in VDR recordings"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${VDRPLUGIN}"
#SRC_URI="http://projects.vdr-developer.org/attachments/download/${REV_DIR}/${P}.tgz"

KEYWORDS=""

SLOT="0"
LICENSE="GPL-2"
IUSE="debug"

DEPEND=">=media-video/vdr-1.2.6
	!media-video/noad"

src_unpack() {
	git_src_unpack
	mv "${S}" "${S}/../.."
	mv "${WORKDIR}/plugin" -Tf "${WORKDIR}/${VDRPLUGIN}-${PV}"

	cd "${S}"
	vdr-plugin_src_unpack all_but_unpack
}

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${P}_stat-include.diff"
	cd "${S}"
	vdr-plugin_src_prepare
}

src_compile() {
	vdr-plugin_src_compile

	cd "${S}/../command"
	mkdir -p po
	emake || die "Compiling command-line markad binary failed"
}

src_install() {

	cd "${S}"
	vdr-plugin_src_install

	cd "${S}/../command"
	dobin markad
	dodir /var/lib/markad
	cp -a logos/* "${D}"/var/lib/markad

	cd "${S}/.."
	dodoc AUTHORS README INSTALL HISTORY
}
