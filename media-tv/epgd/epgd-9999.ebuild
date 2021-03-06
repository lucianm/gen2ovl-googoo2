# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib systemd eutils

PKG_NAME="vdr-epg-daemon"

DESCRIPTION="This daemon is used to download EPG data from the internet and manage it in a mysql database."
HOMEPAGE="http://projects.vdr-developer.org/projects/${PKG_NAME}"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	: ${EGIT_REPO_URI:=${EPGD_GIT_REPO_URI:-https://projects.vdr-developer.org/git/${PKG_NAME}.git}}
	my_branch="http"
	: ${EGIT_BRANCH:=${EPGD_GIT_BRANCH:-${my_branch}}}
	KEYWORDS=""
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://projects.vdr-developer.org/git/${PKG_NAME}.git/snapshot/${PKG_NAME}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86 ~arm"
	S="${WORKDIR}/${PKG_NAME}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="-debug +plugins +http systemd"

DEPEND="app-arch/libarchive
        >=net-misc/curl-7.10
        >=dev-libs/libxslt-1.1.24
        dev-libs/libxml2
        >=dev-db/mysql-5.1.70
        dev-libs/libzip
        dev-libs/openssl
        dev-libs/jansson
        http? ( media-libs/imlib2
    		virtual/jpeg
    		net-libs/libmicrohttpd )
        systemd? ( sys-apps/systemd )"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i Make.config -e "s/\/local//" || die
	sed -i Make.config -e "s/lib/\$(LIBDIR)/" || die
	sed -i contrib/epgd.service -e "s:-c /etc/epgd:-c /etc/epgd -p /usr/$(get_abi_LIBDIR)/epgd/plugins:" || die
	if use debug; then
		sed -i Make.config -e "s/#DEBUG        =/DEBUG        =/"
	else
		sed -i Make.config -e "s/DEBUG        =/#DEBUG        =/"
	fi
	if use systemd; then
		sed -i Make.config -e "s/#SYSD_NOTIFY/SYSD_NOTIFY/" || die
		sed -i Make.config -e "s/#SYSDLIB_209/SYSDLIB_209/" || die
	fi
	epatch_user
}

src_compile() {
	emake -C lib
	emake "${PN}"
	use http && emake epghttpd
	emake lv
	use plugins && emake plugins
}

src_install() {
	# daemon
	dobin epgd
	use http && dobin epghttpd
#	DESTDIR="${D}" emake install-config
	DESTDIR="${D}" emake install-scripts
	use plugins && DESTDIR="${D}" LIBDIR="$(get_abi_LIBDIR)" emake install-plugins
	use http && DESTDIR="${D}" emake install-http
	# mysql plugin
	insinto $(mysql_config --plugindir) || die
	doins $(find -name "mysql*.so")

	# documentation
	dodoc README HISTORY.h TODO README-import-epgsearch
	newdoc epglv/README README.epglv

	# init system stuff
	newinitd "${FILESDIR}"/epgd.initd epgd || die
	newconfd "${FILESDIR}"/epgd.confd epgd || die
	systemd_dounit contrib/epgd.service || die
	if use http; then
		newinitd "${FILESDIR}"/epghttpd.initd epghttpd || die
		newconfd "${FILESDIR}"/epghttpd.confd epghttpd || die
		systemd_dounit "${FILESDIR}"/epghttpd.service || die
	fi

	# prepare daemon configuration
	mkdir -p configs2
	cat configs/channelmap.conf > configs2/channelmap.conf
	cat configs/epgd.conf > configs2/epgd.conf
	find alter -name "*.??l" | xargs cp --target-directory=configs2
	cd configs
	find . -name "*.??l" | xargs cp --target-directory=../configs2
	cd "${S}"

	if use plugins; then
		# install plugins
		insinto "/usr/$(get_abi_LIBDIR)/epgd/plugins" || die
		doins $(find -name "libepgd-*.so")

		# add plugin-specific configs
		find PLUGINS -name "channelmap.con*" -exec cat {} \; >> configs2/channelmap.conf
		find PLUGINS -name "epgd.conf" -exec cat {} \; >> configs2/epgd.conf
		find PLUGINS -name "*.??l" | xargs cp --target-directory=configs2
	fi

	# now actually install (possibly merged) configs
	insinto /etc/epgd
	doins configs2/* || die
	doins configs/recording.py
	doins configs/epg.dat
	dobin scripts/epgd-*

	# development stuff for further, externally-built plugins
	insinto /usr/include/epgd
	doins Make.config
	doins *.h
	for subdir in lib scraper tools; do
		dodir "/usr/include/epgd/${subdir}"
		cd "${subdir}"
		find . -name "*.h" | xargs cp --parents --target-directory="${D}usr/include/epgd/${subdir}"
		cd "${S}"
	done
}

pkg_postinst() {
	einfo "Please refer to the wiki for assistance with the setup"
	einfo "located at http://projects.vdr-developer.org/projects/${PKG_NAME}/wiki"
	einfo "You can use \"epgd-tool\" for installing the MySQL Database"
}
