# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils cmake-utils systemd

#
# Just define the OSCAM_VCS="git" environment variable in /etc/make.conf or in /etc/portage/env/media-tv/oscam
# if you want to pull from a git fork instead of upstream subversion repository.
#
# You can also customize the respective REPO_URI there
#

if [ "${OSCAM_VCS}" == "git" ] ; then
	inherit git-r3
	EGIT_REPO_URI="${OSCAM_EGIT_REPO_URI:-https://github.com/nx111/oscam.git}"
else
	inherit subversion
	ESVN_REPO_URI="${OSCAM_ESVN_REPO_URI:-http://streamboard.de.vu/svn/oscam/trunk}"
fi

DESCRIPTION="OSCam is an Open Source Conditional Access Module software"
HOMEPAGE="http://streamboard.gmc.to:8001/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

PROTOCOLS="camd33 camd35 camd35_tcp newcamd cccam cccshare gbox radegast serial constcw pandora ghttp"
for share in ${PROTOCOLS}; do
	IUSE_PROTOCOLS+=" +protocol_${share}"
done

READERS="nagra irdeto conax cryptoworks seca viaccess videoguard dre tongfang bulcrypt griffin dgcrypt"
for card in ${READERS}; do
	IUSE_READERS+=" +reader_${card}"
done

CARD_READERS="phoenix internal sc8in1 mp35 smargo smartreader db2com stapi"
for cardreader in ${CARD_READERS}; do
	IUSE_CARDREADERS+=" +cardreader_${cardreader}"
done

IUSE="${IUSE_PROTOCOLS} ${IUSE_READERS} ${IUSE_CARDREADERS}
	pcsc +reader usb +www touch +dvbapi irdeto_guessing +anticasc debug +monitor +ssl loadbalancing cacheex cw_cycle_check lcd led ipv6"

REQUIRED_USE="
	protocol_camd35_tcp?	( protocol_camd35 )
	reader_nagra?		( reader )
	reader_irdeto?		( reader irdeto_guessing )
	reader_conax?		( reader )
	reader_cryptoworks?	( reader )
	reader_seca?		( reader )
	reader_viaccess?	( reader )
	reader_videoguard?	( reader )
	reader_dre?		( reader )
	reader_tongfang?	( reader )
	reader_bulcrypt?	( reader )
	reader_griffin?		( reader )
	reader_dgcrypt?		( reader )
	cardreader_db2com?	( reader )
	cardreader_internal?	( reader )
	cardreader_mp35?	( reader usb )
	cardreader_phoenix?	( reader usb )
	cardreader_sc8in1?	( reader usb )
	cardreader_smargo?	( reader usb )
	cardreader_smartreader?	( reader usb )
	cardreader_stapi?	( reader )
	pcsc?			( reader usb )
"

DEPEND="dev-util/cmake"
RDEPEND="${DEPEND}
	dev-libs/openssl
	usb? ( virtual/libusb:1
	       dev-libs/libusb-compat )
	pcsc? ( sys-apps/pcsc-lite )"

RESTRICT="nomirror"

S="${WORKDIR}/${P}"

src_prepare() {
	if [ "${OSCAM_VCS}" == "git" ] ; then
		sed -i "s:svnversion -n .:git describe --always:" config.sh || die "Failed to patch the GIT commit as build string"
	fi
	sed -i "s:share/doc/oscam:share/doc/oscam-${PV}:" CMakeLists.txt || die "Failed to modify doc path"
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCS_CONFDIR=/etc/oscam
		-DCMAKE_VERBOSE_MAKEFILE=ON
		-INCLUDED=Yes
		-DWITH_DEBUG="$(usex debug)"
		-DWEBIF="$(usex www)"
		-DTOUCH="$(usex touch)"
		-DHAVE_DVBAPI="$(usex dvbapi)"
		-DIRDETO_GUESSING="$(usex irdeto_guessing)"
		-DCS_ANTICASC="$(usex anticasc)"
		-DMODULE_MONITOR="$(usex monitor)"
		-DWITH_SSL="$(usex ssl)"
		-DWITH_LB="$(usex loadbalancing)"
		-DCS_CACHEEX="$(usex cacheex)"
		-DLEDSUPPORT="$(usex led)"
		-DLCDSUPPORT="$(usex lcd)"
		-DIPV6SUPPORT="$(usex ipv6)"
		-DCW_CYCLE_CHECK="$(usex cw_cycle_check)"
		-DMODULE_CAMD33="$(usex protocol_camd33)"
		-DMODULE_CAMD35="$(usex protocol_camd35)"
		-DMODULE_CAMD35_TCP="$(usex protocol_camd35_tcp)"
		-DMODULE_NEWCAMD="$(usex protocol_newcamd)"
		-DMODULE_CCCAM="$(usex protocol_cccam)"
		-DMODULE_CCCSHARE="$(usex protocol_cccshare)"
		-DMODULE_GBOX="$(usex protocol_gbox)"
		-DMODULE_RADEGAST="$(usex protocol_radegast)"
		-DMODULE_SERIAL="$(usex protocol_serial)"
		-DMODULE_CONSTCW="$(usex protocol_constcw)"
		-DMODULE_PANDORA="$(usex protocol_pandora)"
		-DMODULE_GHTTP="$(usex protocol_ghttp)"
		-DWITH_CARDREADER="$(usex reader)"
		-DREADER_NAGRA="$(usex reader_nagra)"
		-DREADER_IRDETO="$(usex reader_irdeto)"
		-DREADER_CONAX="$(usex reader_conax)"
		-DREADER_CRYPTOWORKS="$(usex reader_cryptoworks)"
		-DREADER_SECA="$(usex reader_seca)"
		-DREADER_VIACCESS="$(usex reader_viaccess)"
		-DREADER_VIDEOGUARD="$(usex reader_videoguard)"
		-DREADER_DRE="$(usex reader_dre)"
		-DREADER_TONGFANG="$(usex reader_tongfang)"
		-DREADER_BULCRYPT="$(usex reader_bulcrypt)"
		-DREADER_GRIFFIN="$(usex reader_griffin)"
		-DREADER_DGCRYPT="$(usex reader_dgcrypt)"
		-DCARDREADER_PHOENIX="$(usex cardreader_phoenix)"
		-DCARDREADER_INTERNAL="$(usex cardreader_internal)"
		-DCARDREADER_SC8IN1="$(usex cardreader_sc8in1)"
		-DCARDREADER_MP35="$(usex cardreader_mp35)"
		-DCARDREADER_SMARGO="$(usex cardreader_smargo)"
		-DCARDREADER_SMART="$(usex cardreader_smartreader)"
		-DCARDREADER_DB2COM="$(usex cardreader_db2com)"
		-DCARDREADER_STAPI="$(usex cardreader_stapi)"
		-DSTATIC_LIBUSB="$(usex !usb)"
		)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use cardreader_smargo; then
		dobin "${WORKDIR}"/"${P}"_build/utils/list_smargo|| die
	fi

	dobin "${FILESDIR}/oscam_watchdog.sh" || die "dobin oscam_watchdog.sh failed"

	insinto "/etc/${PN}"
	doins -r Distribution/doc/example/*
	fperms 0755 /etc/oscam || die
	newinitd "${FILESDIR}/${PN}.initd" oscam
	newconfd "${FILESDIR}/${PN}.confd" oscam

	systemd_dounit "${FILESDIR}/${PN}.service"

	dodir "/var/log/${PN}/emm"
}

pkg_postinst() {
	einfo "Please refer to the wiki for assistance with the setup "
	einfo "     located at http://streamboard.gmc.to/wiki/OSCam/en "
}
