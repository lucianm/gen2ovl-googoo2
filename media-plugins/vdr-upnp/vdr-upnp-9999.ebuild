# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit vdr-plugin-2 git-2

#VERSION="1065" #every bump, new version


DESCRIPTION="Video Disk Recorder - UPnP/DLNA support Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-${VDRPLUGIN}"
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
S="${WORKDIR}/${VDRPLUGIN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=media-video/vdr-1.7.27
	>=dev-libs/tntdb-1.2
	>=dev-libs/tntnet-2.0
	>=dev-libs/cxxtools-2.0
	>=net-libs/libupnp-1.6.14
	dev-libs/boost"

RDEPEND="${DEPEND}
	>=media-plugins/vdr-streamdev-0.6.0[server,upnp]"

src_prepare() {
	vdr-plugin-2_src_prepare
	# no need to install the license file on gentoo
	sed -i Makefile -e "s: COPYING::"

	epatch ${FILESDIR}/${VDRPLUGIN}-vdr2.1.2compat.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-lboost_date_time-mt_dvb-profiler.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-channel-epg-update-fix.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-stringstream-init.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-virtual-method.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-db-connection-flag.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-no-initial-rec-scan.diff
	epatch ${FILESDIR}/${VDRPLUGIN}-logging-consistent.diff
}

src_install() {

	# install main plugin, normally, just adjust the doc dir to match our versioning
	INSDOCDIR="/usr/share/doc/${P}" \
	vdr-plugin-2_src_install

	dodir /var/cache/vdr/plugins/${VDRPLUGIN}
	fowners -R vdr:vdr /var/cache/vdr/plugins/${VDRPLUGIN}
}
