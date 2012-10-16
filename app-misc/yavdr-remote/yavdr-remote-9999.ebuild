# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit eutils git-2

EGIT_REPO_URI="git://github.com/yavdr/${PN}.git"

DESCRIPTION="RC keymaps and eventmaps for app-misc/eventlircd"
HOMEPAGE="http://www.yavdr.org/documentation/de/ch02s03.html#eventlirc"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="app-misc/eventlircd"

RDEPEND="${DEPEND}"

