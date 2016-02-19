# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit multilib vdr-plugin-2

VERSION="1402" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git"
	EGIT_BRANCH="http"
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git/snapshot/vdr-plugin-${VDRPLUGIN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi

DESCRIPTION="Video Disk Recorder - \"EPG2VDR\" - plugin which retrieves EPG data from a MySQL database"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.27
	sys-apps/util-linux
	>=dev-db/mysql-5.1.70"

RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare
	sed -i Makefile -e "s@-lmysqlclient_r@-L\/usr\/$(get_abi_LIBDIR)\/mysql -lmysqlclient_r@" || die
}

src_install() {
	vdr-plugin-2_src_install
	dodoc README HISTORY.h
}
