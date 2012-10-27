# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Program to view free channels"
HOMEPAGE="http://code.google.com/p/tv-maxe"
SRC_URI="http://tv-maxe.googlecode.com/files/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mplayer +vlc +rtmp +sopcast"

RDEPEND="dev-python/imaging
	mplayer? ( media-video/mplayer )
	vlc? ( media-video/vlc )
	virtual/ffmpeg
	dev-python/python-virtkey
	dev-python/pygtk
	dev-lang/python
	rtmp? ( media-video/rtmpdump )
	sopcast? ( net-p2p/sopcast-bin )"
DEPEND=""

S="${WORKDIR}"

src_prepare() {
	sed -i "s|python|python2|g" ${S}/${PN}-${PV}/${PN} || die "Cannot sed file"
}

src_install() {
	cd "${S}"
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r "${S}"/${PN}-${PV}/*
	fperms 755 /usr/share/${PN}/${PN}
	fperms 755 /usr/share/${PN}
	dosym /usr/share/${PN}/${PN} /usr/bin/${PN}
	make_desktop_entry tv-maxe TV-maxe \
		"/usr/share/tv-maxe/tvmaxe_mini.png" \
		"AudioVideo;Video"
}
