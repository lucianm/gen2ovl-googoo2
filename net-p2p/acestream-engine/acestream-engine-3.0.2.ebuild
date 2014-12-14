# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit multilib python-r1 unpacker

DESCRIPTION="ACE Stream Engine"
HOMEPAGE="http://torrentstream.org/"
SRC_URI="x86? ( http://dl.acestream.org/ubuntu/14/acestream_${PV}_ubuntu_14.04_i686.tar.gz )
	amd64? ( http://dl.acestream.org/ubuntu/14/acestream_${PV}_ubuntu_14.04_x86_64.tar.gz )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+gtk"

DEPEND="dev-python/m2crypto[${PYTHON_USEDEP}]
		dev-python/apsw[${PYTHON_USEDEP}]
		gtk? ( dev-libs/acestream-python-appindicator )"
RDEPEND="${DEPEND}"

if [ "${ARCH}" = "amd64" ]; then
	S="${WORKDIR}/acestream_${PV}_ubuntu_14.04_x86_64"
else
	S="${WORKDIR}/acestream_${PV}_ubuntu_14.04_i686"
fi


QA_PRESTRIPPED="usr/bin/acestreamengine
usr/share/acestream/lib/acestreamengine/Core.so
usr/share/acestream/lib/acestreamengine/node.so
usr/share/acestream/lib/acestreamengine/pycompat.so
usr/share/acestream/lib/acestreamengine/Transport.so
usr/share/acestream/lib/acestreamengine/CoreApp.so
usr/share/acestream/lib/acestreamengine/streamer.so
usr/share/acestream/lib/acestreamengine/live.so"

src_install(){
	dobin acestreamengine
	insinto /usr/share/acestream/lib/acestreamengine
	doins lib/acestreamengine/*.so
	insinto /usr/share/acestream/lib
	doins lib/pycompat27.so
	insinto /usr/share/acestream
	doins -r data
}
