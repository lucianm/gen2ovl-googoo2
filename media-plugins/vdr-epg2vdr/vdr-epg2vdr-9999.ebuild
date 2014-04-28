# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit multilib vdr-plugin-2

VERSION="1402" # every bump, new version

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Video Disk Recorder - \"EPG2VDR\" - plugin which retrieves EPG data from a MySQL database"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.27
	>=dev-db/mysql-5.1.70"

RDEPEND="${DEPEND}"

#VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
#VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

#PATCHES="${FILESDIR}/.."

src_prepare() {
	vdr-plugin-2_src_prepare
	sed -i Makefile -e "s@-lmysqlclient_r@-L\/usr\/$(get_abi_LIBDIR)\/mysql -lmysqlclient_r@" || die
}

src_install() {
	vdr-plugin-2_src_install
	dodoc README HISTORY
}
