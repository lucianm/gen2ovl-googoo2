# Copyright 2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
#
# Author:
#   Lucian Muresan <lucianm@users.sourceforge.net>

# add-local-patches.eclass
#
#   eclass to easily add local patches to ebuilds
#
# based upon vdr-plugin.eclass by
#   Matthias Schwarzott <zzam@gentoo.org>
#   Joerg Bornkessel <hd_brummy@gentoo.org>

add_local_patches() {
	if test -d "${LOCAL_PATCHES_DIR}/${PN}"; then
		echo
		einfo "Applying local patches"
		for LOCALPATCH in "${LOCAL_PATCHES_DIR}/${PN}/${PV}"/*.{diff,patch,diff.gz,patch.gz,diff.bz2,patch.bz2}; do
			test -f "${LOCALPATCH}" && epatch "${LOCALPATCH}"
		done
	fi
}

