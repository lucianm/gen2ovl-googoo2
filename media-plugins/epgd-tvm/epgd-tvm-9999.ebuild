# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib eutils

DESCRIPTION="TVMovie plugin for EPGd"
HOMEPAGE="http://dreipo.cc/tvm/"
#: ${EGIT_REPO_URI:=${EPGD_GIT_REPO_URI:-git://projects.vdr-developer.org/vdr-epg-daemon.git}}
#: ${EGIT_BRANCH:=${EPGD_GIT_BRANCH:-master}}

SRC_URI="http://dreipo.cc/tvm/tvm.diff"

S="${WORKDIR}/vdr-epg-daemon/PLUGINS/tvm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="http"

DEPEND="media-tv/epgd[http=]"

RDEPEND="${DEPEND}"

src_unpack() {
	epatch "${DISTDIR}/${A}"
}

src_prepare() {
	use http && epatch "${FILESDIR}/epgd-tvm_http-changes.diff"
	epatch_user
}

src_compile() {
	EPGD_SRC="/usr/include/epgd" emake
}

src_install() {
	insinto "/usr/$(get_abi_LIBDIR)/epgd/plugins" || die
	doins $(find -name "libepgd-*.so")
	
	insinto /etc/epgd
	doins configs/*.x*l
	newins configs/channelmap-tvm-only.conf tvmovie-channelmap.conf
}

pkg_postinstall() {
	einfo "Please merge any 'TVMovie'-specific channelmap entries you need from"
	einfo "'/etc/epgd/tvmovie-channelmap.conf' to '/etc/epgd/channelmap.conf' manually"
}
