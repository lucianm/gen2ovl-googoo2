# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} pypy )

inherit distutils-r1

DESCRIPTION="Cross Compile Python Extensions"
HOMEPAGE="https://pypi.python.org/pypi/distutilscross"
SRC_URI="https://pypi.python.org/packages/source/d/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86 arm"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( ${PN}.egg-info/{PKG-INFO,SOURCES.txt,dependency_links.txt,entry_points.txt,top_level.txt} )
