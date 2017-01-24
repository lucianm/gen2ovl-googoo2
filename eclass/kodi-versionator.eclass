# Copyright 2017, Lucian Muresan, Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: kodi-branch.eclass
# @MAINTAINER:
# @DESCRIPTION: Provides the Kodi codename according to installed Kodi version,
# useful in media-tv/kodi, media-plugins/kodi-pvr-xxx, media-libs/kodiplatform ebuilds

inherit versionator

case "${EAPI:-0}" in
	4|5|6)
		EXPORT_FUNCTIONS codename_from_kodiversion codename_from_installedkodi
		;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

kodi-versionator_codename_from_kodiversion() { 
	case $1 in
		15)
			echo "Isengard"
			;;
		16)
			echo "Jarvis"
			;;
		17)
			echo "Krypton"
			;;
		*)
			echo "master"
			;;
	esac
}

kodi-versionator_codename_from_installedkodi() {
	KODI_VER=$(best_version media-tv/kodi)
	KODI_MAJOR_VER=$(get_major_version ${KODI_VER/media-tv\/kodi-/})
	kodi-versionator_codename_from_kodiversion "${KODI_MAJOR_VER}"
}
