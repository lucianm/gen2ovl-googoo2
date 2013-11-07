# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2 git-2

EGIT_REPO_URI="${DVBAPI_EGIT_REPO_URI:-git://github.com/manio/vdr-plugin-${VDRPLUGIN}.git}"
EGIT_PROJECT="${PN}-plugin${DVBAPI_EGIT_PROJECT:-}.git"
EGIT_BRANCH="${DVBAPI_EGIT_BRANCH:-master}"

DESCRIPTION="VDR plugin: dvbapi plugin for use with oscam"
HOMEPAGE="https://github.com/manio/vdr-plugin-${VDRPLUGIN}"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE="debug ffdecsa-test libdvbcsa"

DEPEND=">=media-video/vdr-1.7.8
	libdvbcsa? ( media-libs/libdvbcsa )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-plugin

PARALLEL_MODES=""

pkg_setup() {
	vdr-plugin-2_pkg_setup
	if use ffdecsa-test; then
		ewarn ""
		ewarn "You enabled the 'ffdecsa-test' USE flag, you should know that this ebuild will perform"
		ewarn "the FFdecsa 'correctness and speed' tests for all the possible parallel-modes."
		ewarn ""
		ewarn "You may interrupt the build process when prompted, in order to choose the parallel-mode"
		ewarn "that suits you best and re-emerge with USE='-ffdecsa-test', or just let the ebuild"
		ewarn "continue emerging the plugin with the previously selected, or the default mode."
		ewarn ""
	fi
}

collect_parallel_modes() {
	PARALLEL_MODES="$(cat ${S}/FFdecsa/FFdecsa.c | grep '#define PARALLEL_32' | tr -s ' ' | cut -d' ' -f 2)"
	PARALLEL_MODES="${PARALLEL_MODES} $(cat ${S}/FFdecsa/FFdecsa.c | grep '#define PARALLEL_64' | tr -s ' ' | cut -d' ' -f 2)"
	PARALLEL_MODES="${PARALLEL_MODES} $(cat ${S}/FFdecsa/FFdecsa.c | grep '#define PARALLEL_128' | tr -s ' ' | cut -d' ' -f 2)"
}

list_parallel_modes() {
	einfo ""
	for mode in ${PARALLEL_MODES}; do
		einfo "${mode}"
	done
	einfo ""
}

src_prepare() {
	vdr-plugin-2_src_prepare

	# we do not have usleep on gentoo, but sleep with float seconds arguments capability :-)
	sed -i FFdecsa/Makefile \
		-e "s:usleep 200000:sleep 0.2:"

	if use ffdecsa-test; then
		# collect all parallel-modes declared in FFdecsa source
		collect_parallel_modes
		einfo ""
		einfo "Found the following possible FFdecsa parallel-modes:"
		list_parallel_modes
	fi
}

src_compile() {
	if use ffdecsa-test; then

		# loop over all parallel-modes to perform the test
		for mymode in ${PARALLEL_MODES}; do
			einfo ""
			ebegin "Performing FFdecsa tests for ${mymode}"
			#
			MAKEOPTS="-j1" PARALLEL=${mymode} emake FFdecsa/FFdecsa.o || eerror "FFdecsa test for ${mymode} failed..."
			emake clean-ffdecsa || eerror "FFdecsa clean for ${mymode} failed..."
			eend $?
		done
		# cleanup to enforce building ffdecsa with the default or the chosen parallel mode if the user will let the ebuild finish
		cd ${S}/FFdecsa
		emake clean || eerror "Failed to clean FFdecsa test build..."
		cd ${S}

		einfo ""
		einfo "You may interrupt emerging the package now, analyze \"${WORKDIR}/../temp/build.log\" and choose"
		einfo "ONE of the settings:"
		list_parallel_modes
		einfo "whichever gave the best results on your system and set it in the 'FFDECSA_PAR' variable"
		einfo "in your /etc/make.conf and re-emerge while you can now leave the USE flag 'ffdecsa-test' deactivated"
		einfo ""
		ebeep 3
		epause 5
	fi

	# perform just sequentially (otherwise it may fail),
	# and also pass the user's choice for the FFdecsa parallel-mode if it exists
	einfo ""
	
	if ! use libdvbcsa; then
		if ! [ -z ${FFDECSA_PAR} ]; then
			einfo "Found FFdecsa parallel-mode setting FFDECSA_PAR=${FFDECSA_PAR}, will try to build with that."
			BUILD_PARAMS="-j1 PARALLEL=${FFDECSA_PAR}"
		else
			einfo "Compiling FFdecsa with the default parallel-mode set in the package source Makefile as"
			einfo "'PARALLEL   ?= $(grep 'PARALLEL   ?=' Makefile | cut -d' ' -f 5)'."
			einfo "However, you may override this by setting the 'FFDECSA_PAR' variable yourself."
			if ! use ffdecsa-test; then
				einfo ""
				einfo "For possible modes, please consult the 'PARALLEL_...' #defines in FFdecsa.c, or"
				einfo "emerge this package with USE='ffdecsa-test' and choose an appropriate mode listed at the"
				einfo "end of all tests and re-emerge one more time."
			fi
			BUILD_PARAMS="-j1"
		fi
	else
		einfo "Building against external libdvbcsa in favour of the built-in FFdecsa..."
		BUILD_PARAMS="-j1 LIBDVBCSA=1"
	fi

	# now let our base eclass build
	vdr-plugin-2_src_compile
}

src_install() {
	vdr-plugin-2_src_install
	dodoc INSTALL
}
