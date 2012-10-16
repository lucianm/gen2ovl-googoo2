# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.7 3"
#RESTRICT_PYTHON_ABIS="2.[456]"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

VERSION="727" # every bump, new version

DESCRIPTION="Fuse FS which presents VDR recordings as MPEG+NFO files"
HOMEPAGE="http://projects.vdr-developer.org/projects/${PN}"
SRC_URI="http://projects.vdr-developer.org/attachments/download/${VERSION}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="test"

DEPEND="dev-python/setuptools
	dev-python/fuse-python"
RDEPEND=""

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dodoc HISTORY DEVELOPERNOTES
}
