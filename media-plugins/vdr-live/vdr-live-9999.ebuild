# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2 ssl-cert toolchain-funcs

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
if [[ "${PV}" = "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	inherit git
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://vdr.websitec.de/download/${PN}/${P}.tar.gz
		http://live.vdr-developer.org/downloads/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="pcre ssl"

DEPEND="media-video/vdr
	>=dev-libs/tntnet-2.0[ssl=,sdk]
	>=dev-libs/cxxtools-2.0
	pcre? ( >=dev-libs/libpcre-8.12[cxx] )"
RDEPEND="${DEPEND}"

VDR_CONFD_FILE="${FILESDIR}/confd-0.2"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.2.sh"

KEEP_I18NOBJECT="yes"

# Damn vdr.eclass overrides $S...
if [[ "${PV}" = "9999" ]]; then
	S="${WORKDIR}/${VDRPLUGIN}"
else
	S="${WORKDIR}/${P}"
fi

make_live_cert() {
	# TODO: still true?
	# ssl-cert eclass creates a "invalid" cert, create our own one
	local base=$(get_base 1)
	local keydir="/etc/vdr/plugins/live"

	SSL_ORGANIZATION="${SSL_ORGANIZATION:-VDR Plugin Live}"
	SSL_COMMONNAME="${SSL_COMMONNAME:-`hostname -f`}"

	echo
	gen_cnf || return 1
	echo
	gen_key 1 || return 1
	gen_csr 1 || return 1
	gen_crt 1 || return 1
	echo

	install -d "${ROOT}${keydir}"
	install -m0400 "${base}.key" "${ROOT}${keydir}/live-key.pem"
	install -m0444 "${base}.crt" "${ROOT}${keydir}/live.pem"
	chown vdr:vdr "${ROOT}"/etc/vdr/plugins/live/live{,-key}.pem
}

pkg_setup() {
	vdr-plugin-2_pkg_setup

	tc-export CXX AR
}

src_prepare() {
	vdr-plugin-2_src_prepare

	if ! use pcre; then
		sed -i "s:^HAVE_LIBPCRECPP:#HAVE_LIBPCRECPP:" Makefile || die
	fi

	if ! has_version ">=media-video/vdr-1.7.13"; then
		sed -i "s:-include \$(VDRDIR)/Make.global:#-include \$(VDRDIR)/Make.global:" Makefile || die
	fi

	epatch "${FILESDIR}/vdr-live_pcre.patch"
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/live
	doins -r live/*

	fowners -R vdr:vdr /etc/vdr/plugins/live
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	elog "To be able to use all functions of vdr-live"
	elog "you should emerge and enable"
	elog "media-plugins/vdr-epgsearch to search the EPG,"
	elog "media-plugins/vdr-streamdev for Live-TV streaming"

	elog "The default username/password is:"
	elog "\tadmin:live"

	if use ssl ; then
		if path_exists -a "${ROOT}"/etc/vdr/plugins/live/live.pem; then
			einfo "found an existing SSL cert, to create a new SSL cert, run:"
			einfo ""
			einfo "emerge --config ${PN}"
		else
			einfo "No SSL cert found, creating a default one now"
			make_live_cert
		fi
	fi
}

pkg_config() {
	make_live_cert
}
