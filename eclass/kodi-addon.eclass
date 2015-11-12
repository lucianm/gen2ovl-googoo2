# Copyright 2015 Daniel 'herrnst' Scheller, Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: kodi-addon.eclass
# @MAINTAINER:
# nst@kodi.tv
# @BLURB: Helper for correct building and (importantly) installing Kodi addon packages.
# @DESCRIPTION:
# Provides a src_configure function for correct CMake configuration

inherit multilib cmake-utils versionator

case "${EAPI:-0}" in
	4|5)
		EXPORT_FUNCTIONS pvr_branch src_prepare src_configure
		;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

kodi-addon_pvr_branch() { 
	KODI_VER=$(best_version media-tv/kodi)
	KODI_MAJOR_VER=$(get_major_version ${KODI_VER/media-tv\/kodi-/})
	case "${KODI_MAJOR_VER}" in
		15)
			echo "Isengard"
			;;
		*)
			echo "master"
			;;
	esac
}

kodi-addon_src_fetch() {
	echo get_kodi_major_ver
}

PLUGINNAME="${PN/kodi-/}"
PLUGINNAME="${PLUGINNAME/-/.}"
PLUGINNAME="${PLUGINNAME/-/.}"

kodi-addon_src_prepare() {
	cmake-utils_src_prepare
	if [ -f ${S}/${PLUGINNAME}/addon.xml.in ]; then
		mv ${S}/${PLUGINNAME}/addon.xml.in ${S}/${PLUGINNAME}/addon.xml
		sed -i ${S}/${PLUGINNAME}/addon.xml \
		    -e "s:@PLATFORM@:linux:" \
		    -e "s:@LIBRARY_FILENAME@:${PLUGINNAME}.so:"
	fi
}

# @FUNCTION: kodi-addon_src_configure
# @DESCRIPTION:
# Configure handling for Kodi addons
kodi-addon_src_configure() {

	mycmakeargs+=(
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)/kodi
	)

	cmake-utils_src_configure
}
