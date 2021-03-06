# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vdr-plugin-2 git-r3

DVDARCHIVE="dvdarchive-2.3-beta.sh"

DESCRIPTION="VDR Plugin: Extended recordings menu"
HOMEPAGE="https://projects.vdr-developer.org/projects/plg-extrecmenu"
EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="media-video/vdr"

S="${WORKDIR}/${VDRPLUGIN}"

src_prepare() {
	rm "${S}"/po/{ca_ES,da_DK,el_GR,et_EE,hr_HR,hu_HU,nl_NL,nn_NO,pl_PL,pt_PT,ro_RO,ru_RU,sl_SI,sv_SE,tr_TR}.po || die

	eapply "${FILESDIR}/${P}_c++11.patch"

	cd "${WORKDIR}" || die
	eapply -p0 "${FILESDIR}/${DVDARCHIVE%.sh}-configfile.patch"

	vdr-plugin-2_src_prepare
}

src_install() {
	vdr-plugin-2_src_install

	cd "${WORKDIR}"
	newbin ${DVDARCHIVE} dvdarchive.sh

	insinto /etc/vdr
	doins "${FILESDIR}"/dvdarchive.conf
}
