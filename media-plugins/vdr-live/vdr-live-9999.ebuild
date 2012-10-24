# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin ssl-cert

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
if [[ "${PV}" = "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	inherit git
else
	SRC_URI="mirror://gentoo/${P}.tar.gz
		http://vdr.websitec.de/download/${PN}/${P}.tar.gz
		http://live.vdr-developer.org/downloads/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="ssl"

DEPEND="media-video/vdr
	>=dev-libs/tntnet-2.0[ssl=,sdk]
	>=dev-libs/cxxtools-2.0"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${VDRPLUGIN}"

VDR_CONFD_FILE="${FILESDIR}/confd-0.2"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.2.sh"

make_live_cert() {
	# ssl-cert eclass create invalide cert, create my own

	SSL_ORGANIZATION="${SSL_ORGANIZATION:-VDR Plugin Live}"
	SSL_COMMONNAME="${SSL_COMMONNAME:-`hostname -f`}"

	echo
	gen_cnf || return 1
	echo
	gen_key 1 || return 1
	gen_csr 1 || return 1
	gen_crt 1 || return 1
	echo
}

src_unpack() {
if [[ "${PV}" = "9999" ]]; then
	git_src_unpack
	cd "${S}"
	vdr-plugin_src_unpack all_but_unpack
else
	vdr-plugin_src_unpack
fi
}

src_prepare() {
	vdr-plugin_src_prepare

	#make it work with /bin/sh as indicated in the file header
	sed -e "18s/==/=/" -i  buildutil/version-util

	sed -e "s/ERROR:/WARNING:/" -i tntconfig.cpp

	if ! has_version ">=media-video/vdr-1.7.13"; then
	sed -i "s:-include \$(VDRDIR)/Make.global:#-include \$(VDRDIR)/Make.global:" Makefile
	fi
}

src_install() {
	vdr-plugin_src_install

	cd "${S}/live"
	insinto /etc/vdr/plugins/live
	doins -r *

	chown vdr:vdr -R "${D}"/etc/vdr/plugins/live
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "To be able to use all functions of vdr-live"
	elog "you should emerge and enable"
	elog "=media-plugins/vdr-epgsearch-0.9.25_beta* to search the EPG,"
	elog "media-plugins/vdr-streamdev-0.5.0 for Live-TV streaming"
	echo
	elog "On first install use login:pass"
	elog "\tadmin:live"
	echo
	ewarn "This is a developer snapshot"
	einfo "On problems, use the stable amd64, x86 versions of"
	einfo "dev-libs/tntnet dev-libs/cxxtools media-plugins/vdr-live"

	# Do not install live.{key,crt) SSL certificates if they already exist
	if use ssl && [[ ! -f "${ROOT}"/etc/vdr/plugins/live/live.key \
		&& ! -f "${ROOT}"/etc/vdr/plugins/live/live.crt ]] ; then
			make_live_cert
			local base=$(get_base 1)
			local keydir="/etc/vdr/plugins/live"
			install -d "${ROOT}${keydir}"
			install -m0400 "${base}.key" "${ROOT}${keydir}/live.key"
			install -m0444 "${base}.crt" "${ROOT}${keydir}/live.crt"
			chown vdr:vdr "${ROOT}"/etc/vdr/plugins/live/live.*
	fi
}
