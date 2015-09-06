# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

S="${WORKDIR}"
DESCRIPTION="KeePass Google Sync Plugin"
HOMEPAGE="http://sourceforge.net/projects/kp-googlesync"
SRC_URI="mirror://sourceforge/kp-googlesync/GoogleSyncPlugin-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/keepass
	dev-dotnet/log4net
	<dev-lang/mono-4.0.0.0"
DEPEND="${RDEPEND}"

src_install() {
	keepass_dir="/usr/$(get_libdir)/keepass"
	insinto $keepass_dir
	doins GoogleSyncPlugin.plgx

	dosym "../mono/gac/System.ServiceModel.Web/3.5.0.0__31bf3856ad364e35/System.ServiceModel.Web.dll" "$keepass_dir/System.ServiceModel.Web.dll"
	dosym "../mono/log4net/log4net.dll" "$keepass_dir/log4net.dll"

	dodoc readme.txt
}
