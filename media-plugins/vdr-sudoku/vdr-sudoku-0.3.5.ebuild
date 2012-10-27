# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: to generate and solve Number Place puzzles, so called Sudokus."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-sudoku
"
SRC_URI="http://projects.vdr-developer.org/attachments/download/280/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-video/vdr"
