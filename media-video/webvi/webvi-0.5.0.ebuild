# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Video website browser / viewer library needed for the VDR plugin vdr-webvideo"

HOMEPAGE="http://users.tkk.fi/~aajanki/vdr/webvideo/"

IUSE="+yle"

SRC_URI="http://projects.vdr-developer.org/attachments/download/1355/vdr-webvideo-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pycurl
	dev-libs/libxml2
	dev-libs/libxslt
	yle? (	>=media-video/yle-dl-2.0.1 )
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/webvideo-${PV}"


src_prepare() {
#	epatch "${FILESDIR}/${PN}-0.3.1_DESTDIR.diff"
	sed -i src/libwebvi/Makefile -e "s:\$(CC):gcc:" || die "Failed to sed gcc call in libwebvi/MAkefile"
	sed -i src/libwebvi/Makefile -e "s:/sbin/ldconfig:#/sbin/ldconfig:" || die "Failed to remove ldconfig call from libwebvi/MAkefile"
	if ! use yle; then
		rm -Rf templates/bin
		rm -Rf templates/areena.yle.fi
	fi
}

src_compile() {
	DESTDIR="${D}" PREFIX=/usr VDRDIR="${PREFIX}"/include/vdr emake libwebvi
}

src_install() {
	if [ ${ARCH} = "amd64" ]; then
		dodir /usr/lib64
		dosym lib64 /usr/lib
	fi
	cd ${S}
	DESTDIR="${D}" PREFIX=/usr VDRDIR="${PREFIX}"/include/vdr emake install-webvi
	dodir /etc
	DESTDIR="${D}" PREFIX=/usr VDRDIR="${PREFIX}"/include/vdr VDRPLUGINCONFDIR="/etc/vdr/plugins" emake install-conf
	dodoc HISTORY README README.webvi TODO doc/*
	if [ ${ARCH} = "amd64" ]; then
		rm ${D}/usr/lib
	fi
}
