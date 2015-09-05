# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 eutils versionator

DESCRIPTION="VDR-plugin : Renders media from a Plexmediaserver transcoder directly in VDR"
HOMEPAGE="https://github.com/chriszero/vdr-plugin-${VDRPLUGIN}"
if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/chriszero/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/chriszero/vdr-plugin-${VDRPLUGIN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi

SLOT="0"
LICENSE="GPL-2"
IUSE="+skindesigner"

DEPEND=">=media-video/vdr-2.1.10
	dev-libs/poco
	dev-libs/pcre++
	skindesigner? ( media-plugins/vdr-skindesigner )"

src_prepare() {
	vdr-plugin-2_src_prepare
}

src_install() {
	vdr-plugin-2_src_install
	
	version_compare "${PV}" "0.1.4"
	if [[ $? -eq 3 ]]; then

		dodoc -r templates

		if use skindesigner; then
			insinto /usr/share/vdr/plugins/skindesigner
			doins -r skins
		fi
	fi

	dodoc "VDR Plex Plugin.xml"
}
