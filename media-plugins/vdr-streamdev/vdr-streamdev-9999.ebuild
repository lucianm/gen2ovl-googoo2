# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit vdr-plugin-2 git-r3

#VERSION="969" # every bump, new version !

DESCRIPTION="VDR Plugin: Client/Server and http streaming plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-streamdev"
EGIT_REPO_URI="https://projects.vdr-developer.org/git/vdr-plugin-${VDRPLUGIN}.git"
S="${WORKDIR}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="client +server upnp"

DEPEND=">=media-video/vdr-1.7.25"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( client server )
	upnp? ( server )"

# vdr-plugin-2.eclass changes
PO_SUBDIR="client server"

src_prepare() {
	use upnp && eapply "${FILESDIR}/${P}_upnp.diff"

	vdr-plugin-2_src_prepare

	# make subdir libdvbmpeg respect CXXFLAGS
	sed -i Makefile \
		-e '/CXXFLAGS.*+=/s:^:#:'

	for flag in client server; do
		if ! use ${flag}; then
			sed -i Makefile \
				-e '/^.PHONY:/s/'${flag}'//' \
				-e '/^all:/s/'${flag}'//'
		fi
	done

	sed -i server/Makefile \
		-i client/Makefile \
		-e "s:\$(CXXFLAGS) -shared:\$(CXXFLAGS) \$(LDFLAGS) -shared:"

	sed -i "s:include \$(VDRDIR)/Make.global:-include \$(VDRDIR)/Make.global:" Makefile

	fix_vdr_libsi_include server/livestreamer.c

	make -C ./tools .dependencies
	sed -i "s:tools\/:..\/tools\/:" tools/.dependencies
	sed -i "s:h tools\/:h ..\/tools\/:" tools/.dependencies
	sed -i "s:h common.h:h ..\/common.h:" tools/.dependencies

	eapply_user
}

src_compile() {
	INCLUDES=-I.. vdr-plugin-2_src_compile
}


src_install() {
	cd "${S}"
	insinto /etc/vdr/conf.avail
	if use client; then
		doins "${FILESDIR}"/${VDRPLUGIN}-client.conf
		mv ./client/libvdr-${VDRPLUGIN}-client.so libvdr-${VDRPLUGIN}-client.so.${APIVERSION}
	fi
	if use server; then
		doins "${FILESDIR}"/${VDRPLUGIN}-server.conf
		mv ./server/libvdr-${VDRPLUGIN}-server.so libvdr-${VDRPLUGIN}-server.so.${APIVERSION}
	fi

	vdr-plugin-2_src_install

	if use server; then
		exeinto /usr/share/vdr/plugins/streamdev-server
		doexe streamdev-server/externremux.sh

		insinto /usr/share/vdr/rcscript
		newins "${FILESDIR}"/rc-addon-9999.sh plugin-streamdev-server.sh

		insinto /etc/conf.d
		newins "${FILESDIR}"/confd-9999 vdr.streamdev-server

		insinto /etc/vdr/plugins/streamdev-server
		newins streamdev-server/streamdevhosts.conf streamdevhosts.conf
		fowners vdr:vdr /etc/vdr/plugins/streamdev-server -R
	fi
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.6.0"
	previous_less_than_0_6_0=$?
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	if [[ -e "${ROOT}"/etc/vdr/plugins/streamdev/streamdevhosts.conf ]]; then
		einfo "move config file to new config DIR ${ROOT}/etc/vdr/plugins/streamdev-server/"
		mv "${ROOT}"/etc/vdr/plugins/streamdev/streamdevhosts.conf "${ROOT}"/etc/vdr/plugins/streamdev-server/streamdevhosts.conf
	fi

	if [[ $previous_less_than_0_6_0 = 0 ]]; then
		einfo "The server-side setting \"Suspend behaviour\" has been dropped in 0.6.0 in favour"
		einfo "of priority based precedence. A priority of 0 and above means that clients"
		einfo "have precedence. A negative priority gives precedence to local live TV on the"
		einfo "server. So if \"Suspend behaviour\" was previously set to \"Client may suspend\" or"
		einfo "\"Never suspended\", you will have to configure a negative priority. If the"
		einfo "\"Suspend behaviour\" was set to \"Always suspended\", the default values should do."
		einfo ""
		einfo "Configure the desired priorities for HTTP and IGMP Multicast streaming in the"
		einfo "settings of streamdev-server. If you haven't updated all your streamdev-clients"
		einfo "to at least 0.5.2, configure \"Legacy Client Priority\", too."
		einfo ""
		einfo "In streamdev-client, you should set \"Minimum Priority\" to -99. Adjust \"Live TV"
		einfo "Priority\" if necessary."
	fi
}
