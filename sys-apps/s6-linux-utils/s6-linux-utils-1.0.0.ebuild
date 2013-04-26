# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="set of minimalistic Linux-specific system utilities"
HOMEPAGE="http://www.skarnet.org/software/s6-linux-utils/index.html"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND=">=dev-libs/skalibs-1.3.0"
RDEPEND=""

S=${WORKDIR}/admin/${P}

src_prepare() {
   echo ${S} > conf-compile/conf-sp_root
   mkdir -p package/prog/skalibs/sysdeps
#   cp -a /usr/$(get_libdir)/skalibs/sysdeps package/prog/skalibs/ || die "is dev-libs/skalibs installed?"
#   ln -s ../../package/prog/skalibs/sysdeps/systype ${S}/src/sys/systype
}

src_configure() {
   echo $(tc-getCC) ${CFLAGS} > conf-compile/conf-cc
   echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-dynld
   echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-ld
   echo /usr/include/skalibs > conf-compile/path-include
   echo /usr/$(get_libdir)/skalibs > conf-compile/path-library
   use static-libs && touch conf-compile/flag-allstatic
}

src_compile() {
   emake -j1
}

src_install() {

   exeinto /sbin
   doexe command/*

   cd doc || die
   for f in $(find . -type f ! -name "*.html" ! -name "COPYING") ; do
      docinto $(dirname f)
      dodoc $f
   done
   docinto html
   use doc && dohtml -r .
}

