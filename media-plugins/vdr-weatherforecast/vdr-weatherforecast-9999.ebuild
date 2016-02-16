# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	SRC_URI="http://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git/snapshot/vdr-plugin-${VDRPLUGIN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86 ~arm"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi

DESCRIPTION="Video Disk Recorder - \"WeatherForecast\" provides a weather forecast \(who'd have thought? \;\) ) based on forecast.io data"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-${VDRPLUGIN}"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.28
	net-misc/curl
	dev-libs/jansson
	>=media-libs/libskindesignerapi-0.1.0
	>=media-plugins/vdr-skindesigner-0.4.0"

RDEPEND="${DEPEND}"

#VDR_RCADDON_FILE="${FILESDIR}/rc-addon.sh"
#VDR_CONFD_FILE="${FILESDIR}/confd-v2"
VDR_RCADDON_FILE_4ARGSDIR="${FILESDIR}/rc-addon_4argsdir.sh"
#VDR_CONFD_FILE_4ARGSDIR="${FILESDIR}/confd_4argsdir"
