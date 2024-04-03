# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ssl-cert toolchain-funcs vdr-plugin-2

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="https://github.com/MarkusEh/vdr-plugin-live"
if [[ "${PV}" = "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
	#EGIT_REPO_URI="https://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git"
	EGIT_REPO_URI="https://github.com/REELcoder/vdr-plugin-${VDRPLUGIN}.git"
	inherit git-r3
	S="${WORKDIR}/${P}"
else
	MY_P="v3.3.4"
	SRC_URI="https://github.com/MarkusEh/vdr-plugin-${VDRPLUGIN}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86 arm"
	S="${WORKDIR}/vdr-plugin-${VDRPLUGIN}-${PV}"
fi

LICENSE="Apache-2.0 GPL-2+ RSA"
SLOT="0"
IUSE="pcre ssl"

DEPEND="media-video/vdr
	>=dev-libs/tntnet-3[ssl=]
	>=dev-libs/cxxtools-3
	pcre? ( >=dev-libs/libpcre-8.12[cxx] )"
RDEPEND="${DEPEND}"


VDR_CONFD_FILE="${FILESDIR}/confd-2.3"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-2.3.sh"

KEEP_I18NOBJECT="yes"

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

	chown vdr:vdr "${ROOT}${keydir}/live.pem"
	chown vdr:vdr "${ROOT}${keydir}/live-key.pem"
}

src_prepare() {
	vdr-plugin-2_src_prepare

	if ! use pcre; then
		sed -i "s:^HAVE_LIBPCRECPP:#HAVE_LIBPCRECPP:" Makefile || die
	fi
}

src_install() {
	vdr-plugin-2_src_install

	insinto /usr/share/vdr/plugins/live
	doins -r live/*

	fowners -R vdr:vdr /usr/share/vdr/plugins/live
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	elog "To be able to use all functions of vdr-live"
	elog "you should emerge and enable"
	elog "media-plugins/vdr-epgsearch to search the EPG,"
	elog "media-plugins/vdr-streamdev for Live-TV streaming"
	elog "media-plugins/vdr-tvscraper for movie information"

	elog "The default username/password is:"
	elog "\tadmin:live"

	if use ssl ; then
			make_live_cert
	fi
}
