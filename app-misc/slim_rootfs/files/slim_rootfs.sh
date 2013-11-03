#!/bin/sh

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#
# 2013-11-03, v.0.0.1    lucianm <lucianm@users.sourceforge.net>


#set -x

source /usr/lib/misc/elog-functions.sh
source /etc/slim_rootfs.conf

retuval() {
	retval=${1}
	eend ${retval}
	[ ${retval} -ne 0 ] && \
	ewarn "${2}" && \
	return 1
}

# delete explicitly listed objects
for obj in $DEL_OBJ_PATHS; do
	if [ -f "$obj" ]; then
		rm -R $obj
		retuval ${?} "Failed to delete '$obj'"
	fi
done

# run listed cleanup commands
for cmd in "${CLEANUP_CMDS[@]}"; do
	${cmd}
done

exit 0
