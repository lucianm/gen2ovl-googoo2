# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=(python2_7)

inherit git-2 distutils-r1

DESCRIPTION="An unofficial api for Google Play Music"
HOMEPAGE="https://github.com/simon-weber/Unofficial-Google-Music-API/"
EGIT_REPO_URI="git://github.com/simon-weber/Unofficial-Google-Music-API.git"
EGIT_PROJECT="${PN}.git"
#SRC_URI="https://github.com/simon-weber/Unofficial-Google-Music-API/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

S="${WORKDIR}/${PN}"

RDEPEND="dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/validictory[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-libs/protobuf[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/proboscis[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	${PYTHON} ${PN}/test/run_tests.py --group=local || die
}
