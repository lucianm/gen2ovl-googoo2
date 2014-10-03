# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit channel-logos git-2

HOMEPAGE=""
SRC_URI="
	http://www.lyngsat-logo.com/hires/tt/tvr_hd.png
	http://www.lyngsat-logo.com/hires/tt/tvr_moldova.png
	http://www.lyngsat-logo.com/hires/tt/tvr1_ro.png
	http://www.lyngsat-logo.com/hires/tt/tvr2_ro.png
	http://www.lyngsat-logo.com/hires/tt/tvr_international.png
	http://www.lyngsat-logo.com/hires/tt/tvr3_ro.png
	http://www.lyngsat-logo.com/hires/tt/tvr_cluj.png
	http://www.lyngsat-logo.com/hires/tt/tvr_craiova.png
	http://www.lyngsat-logo.com/hires/tt/tvr_iasi.png
	http://www.lyngsat-logo.com/hires/tt/tvr_news_ro.png
	http://www.lyngsat-logo.com/hires/tt/tvr_tirgu_mures.png
	http://www.lyngsat-logo.com/hires/tt/tvr_timisoara.png
	http://www.lyngsat-logo.com/hires/uu/u_tv.png
	http://www.lyngsat-logo.com/hires/aa/antena3_ro.png
	http://www.lyngsat-logo.com/hires/bb/b1_tv.png
	http://www.lyngsat-logo.com/hires/ee/etno_tv.png
	http://www.lyngsat-logo.com/hires/ff/favorit_tv_ro.png
	http://www.lyngsat-logo.com/hires/pp/pro_tv_international.png
	http://www.lyngsat-logo.com/hires/pp/pro_tv.png
	http://www.lyngsat-logo.com/hires/pp/pro_tv_chisinau.png
	http://www.lyngsat-logo.com/hires/rr/realitatea_tv.png
	http://www.lyngsat-logo.com/hires/tt/taraf_tv.png
	http://www.lyngsat-logo.com/hires/num/1music_channel_ro.png
	http://www.lyngsat-logo.com/hires/aa/antena_stars_ro.png
	http://www.lyngsat-logo.com/hires/aa/acasa_tv.png
	http://www.lyngsat-logo.com/hires/aa/acasa_tv_gold.png
	http://www.lyngsat-logo.com/hires/aa/acasa_tv_hd.png
	http://www.lyngsat-logo.com/hires/aa/antena1_ro.png
	http://www.lyngsat-logo.com/hires/cc/cinemax_ce.png
	http://www.lyngsat-logo.com/hires/cc/cinemax2_ce.png
	http://www.lyngsat-logo.com/hires/dd/da_vinci_learning.png
	http://www.lyngsat-logo.com/hires/dd/digi_24_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_24_ro_hd.png
	http://www.lyngsat-logo.com/hires/dd/digi_animal_world_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_film_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_life_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_sport_liga_majstrov1.png
	http://www.lyngsat-logo.com/hires/dd/digi_sport_liga_majstrov2.png
	http://www.lyngsat-logo.com/hires/dd/digi_sport1_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_sport2_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_sport3_ro.png
	http://www.lyngsat-logo.com/hires/dd/digi_world_ro.png
	http://www.lyngsat-logo.com/hires/dd/dolce_mooz_dance_hd.png
	http://www.lyngsat-logo.com/hires/dd/dolce_mooz_hd.png
	http://www.lyngsat-logo.com/hires/dd/dolce_mooz_hits.png
	http://www.lyngsat-logo.com/hires/dd/dolce_mooz_ro.png
	http://www.lyngsat-logo.com/hires/dd/dolce_sport_ro.png
	http://www.lyngsat-logo.com/hires/dd/duck_tv.png
	http://www.lyngsat-logo.com/hires/ee/euforia_lifestyle_tv.png
	http://www.lyngsat-logo.com/hires/hh/hbo_comedy_ro.png
	http://www.lyngsat-logo.com/hires/ff/filmbox_hd.png
	http://www.lyngsat-logo.com/hires/hh/history_europe_hd.png
	http://www.lyngsat-logo.com/hires/ll/look_tv_ro.png
	http://www.lyngsat-logo.com/hires/ll/look_tv_ro_plus.png
	http://www.lyngsat-logo.com/hires/mm/money_tv_ro.png
	http://www.lyngsat-logo.com/hires/nn/nasul_tv.png
	http://www.lyngsat-logo.com/hires/tt/the_money_channel_ro.png
	http://www.lyngsat-logo.com/hires/tt/tv_sibiu_ro.png
	http://www.lyngsat-logo.com/hires/tt/tvh_ro.png
	http://www.lyngsat-logo.com/hires/zz/zu_tv_ro.png
	http://www.lyngsat-logo.com/logo/tv/dd/digi_premium.png
	http://www.lyngsat-logo.com/logo/tv/tt/trinitas_tv.png
	http://www.lyngsat-logo.com/logo/tv/kk/kanal_d_hd.png
	http://www.lyngsat-logo.com/logo/tv/kk/kanal_d_ro.png
	http://www.lyngsat-logo.com/logo/tv/pp/prima_tv.png
	http://www.lyngsat-logo.com/logo/tv/dd/direct_digital_tv.png
	http://www.lyngsat-logo.com/logo/tv/nn/ntv_ro.png
	http://www.lyngsat-logo.com/logo/tv/pp/pro_cinema.png
	http://www.lyngsat-logo.com/logo/tv/ss/sport_ro.png
	http://www.lyngsat-logo.com/logo/tv/ss/sport_ro_hd.png
	http://www.lyngsat-logo.com/hires/cc/credo_tv.png
	http://www.lyngsat-logo.com/hires/hh/hora_tv.png
	http://www.lyngsat-logo.com/hires/nn/neptun_tv.png
	http://www.lyngsat-logo.com/hires/ss/sport1_ro.png
	http://upload.wikimedia.org/wikipedia/en/0/02/National_TV.png
	https://bytebucket.org/picons/logos/raw/550df5e5a015fa0283aee3bdc9556c09890cee4a/tv/travelchannelhd.png
	https://bytebucket.org/picons/logos/raw/550df5e5a015fa0283aee3bdc9556c09890cee4a/tv/sundancechannelhd.png
	https://bytebucket.org/picons/logos/raw/550df5e5a015fa0283aee3bdc9556c09890cee4a/tv/cartoonnetwork_tcm.png
"

EGIT_REPO_URI="git://github.com/3PO/Senderlogos.git"
EGIT_PROJECT="${PN}.git"

LICENSE="3PO"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

S=${WORKDIR}

RRDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack

	#rm -f "${S}/prima tv.png"

	cp ${DISTDIR}/*.png ${S}
}

src_prepare() {
	rm -f "separatorlogos/ard dritte programme.png"
	rm -f "separatorlogos/zdf vision hd.png"

	for logoname in ${SRC_URI}; do
		logoname="$(echo ${logoname} | rev | cut -d/ -f1 | rev)"
		logoname_new="${logoname}"
		[[ ${logoname} == *sport_ro* ]] || logoname_new="${logoname//_ro/}"
		[[ ${logoname_new} == *dolce_mooz* ]] && logoname_new="${logoname//dolce_/}"
		logoname_new="${logoname_new//_/ }"
		mv -f "${logoname}" "${logoname_new}"
	done

	convmv --notest --replace -f cp-850 -t utf-8 -r "${S}"/

	#channel-logos_src_prepare

	ln -f -s "national geographic hd.png" "ngc hd.png"
	ln -f -s "da vinci learning.png" "da vinci u.png"
	ln -f -s "history hd.png" "history chnl hd.png"
	ln -f -s "duck tv.png" "ducktv.png"
	ln -f -s "disney channel.png" "disney rom.png"
	ln -f -s "mtv.png" "mtv romania.png"
	ln -f -s "mtv euro.png" "mtv europe.png"
	ln -f -s "mtv euro.png" "mtv european.png"
	ln -f -s "vh1.png" "vh1 romania.png"
	ln -f -s "vh1.png" "vh 1.png"
	ln -f -s "etno tv.png" "etno.png"
	ln -f -s "sport ro.png" "sport.ro.png"
	ln -f -s "eurosport.png" "eurosport romania.png"
	ln -f -s "auto motor und sport.png" "auto motor sport.png"
	ln -f -s "euforia lifestyle tv.png" "euforia lifestyle.png"
	ln -f -s "acasa tv.png" "acasa.png"
	ln -f -s "acasa tv.png" "acasatv.png"
	ln -f -s "b1 tv.png" "b1.png"
	ln -f -s "trinitas tv.png" "trinitas.png"
	ln -f -s "nickelodeonhd.png" "nickelodeon hd.png"
	ln -f -s "pro cinema.png" "procinema.png"
	ln -f -s "hbo.png" "hbo ro.png"
	ln -f -s "hbo.png" "hbo romania.png"
	ln -f -s "tvr1.png" "tvr 1.png"
	ln -f -s "tvr2.png" "tvr 2.png"
	ln -f -s "tvr3.png" "tvr 3.png"
	ln -f -s "prima tv.png" "prima tv ro.png"
	ln -f -s "mooz dance hd.png" "mooz dance.png"
	ln -f -s "pro tv international.png" "protv international.png"
	ln -f -s "digi sport1.png" "digi sport 1.png"
	ln -f -s "digi sport2.png" "digi sport 2.png"
	ln -f -s "digi sport3.png" "digi sport 3.png"
	ln -f -s "travelchannelhd.png" "travel channel hd.png"
	ln -f -s "sundancechannelhd.png" "sundance hd.png"
	ln -f -s "cartoonnetwork tcm.png" "cartoon-tcm.png"
	ln -f -s "cartoonnetwork tcm.png" "tcm cartoon.png"
	ln -f -s "neptun tv.png" "tv neptun.png"
	ln -f -s "fishing and hunting.png" "fishing&hunting.png"
	mv -f "National TV.png" "national tv.png"
	ln -f -s "national tv.png" "national.png"
}

src_install() {
	insinto "${CHANLOGOBASE}/${LOGOPACKNAME}"
	doins -r *.png Alternativlogos backgrounds l-tv nick separatorlogos

	# such strange subdirs with spaces at the end cannot be copied, but directly created: 
	dodir "${CHANLOGOBASE}/${LOGOPACKNAME}/cartoon network ro"
	dosym "../cartoonnetwork tcm.png" "${CHANLOGOBASE}/${LOGOPACKNAME}/cartoon network ro/ tcm ro.png"
	dodir "${CHANLOGOBASE}/${LOGOPACKNAME}/cartoon network "
	dosym "../cartoonnetwork tcm.png" "${CHANLOGOBASE}/${LOGOPACKNAME}/cartoon network / tcm.png"

	# same for names containing utf-8
	dosym "acasa tv.png" "${CHANLOGOBASE}/${LOGOPACKNAME}/acasă.png"
	dosym "acasa tv gold.png" "${CHANLOGOBASE}/${LOGOPACKNAME}/acasă gold.png"

}

