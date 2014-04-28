# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib systemd git-2

DESCRIPTION="This daemon is used to download EPG data from the internet and manage it in a mysql database."
HOMEPAGE="http://projects.vdr-developer.org/projects/vdr-epg-daemon"
: ${EGIT_REPO_URI:=${EPGD_GIT_REPO_URI:-git://projects.vdr-developer.org/vdr-epg-daemon.git}}
: ${EGIT_BRANCH:=${EPGD_GIT_BRANCH:-master}}

SRC_URI=""

S="${WORKDIR}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="-debug +plugins"

DEPEND="app-arch/libarchive
        >=net-misc/curl-7.10
        >=dev-libs/libxslt-1.1.24
        dev-libs/libxml2
        >=dev-db/mysql-5.1.70
        dev-libs/libzip
        dev-libs/openssl
        dev-libs/jansson"

RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack || default
}

src_prepare() {
	sed -i Make.config -e "s/\/local//"
	sed -i Make.config -e "s/lib/\$(LIBDIR)/"
	use debug && sed -i Make.config -e "s/# DEBUG/DEBUG/"
	epatch_user
}

src_compile() {
	emake ${PN}
	emake lv
	use plugins && emake plugins
}

src_install() {
	# daemon
	dobin epgd
#	DESTDIR="${D}" emake install-config
#	DESTDIR="${D}" emake install-scripts
#	use plugins && DESTDIR="${D}" LIBDIR="$(get_abi_LIBDIR)" emake install-plugins

	# documentation
	dodoc README HISTORY
	newdoc epglv/README README.epglv

	# init system stuff
	newinitd "${FILESDIR}"/epgd.initd epgd || die
	newconfd "${FILESDIR}"/epgd.confd epgd || die
	systemd_dounit contrib/epgd.service || die

	# mysql plugin
	insinto $(mysql_config --plugindir) || die
	doins $(find -name "mysql*.so")

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
	einfo "located at http://projects.vdr-developer.org/projects/vdr-epg-daemon/wiki"
	einfo "You can use \"epgd-tool\" for installing the MySQL Database"
}
