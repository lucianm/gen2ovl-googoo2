#!/bin/sh

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#
# /etc/init.d/squash_portage allows efficient compression of
# Gentoo portage arborescence, yielding also in speedup because of using tmpfs
#
# It requires support for the loop device and squashfs enabled in the kernel,
# module autoloading is also *highly* recommended.
# sys-fs/squashfs, sys-fs/squashfs-tools and sys-fs/aufs
# or sys-fs/aufs2 (recommended) are necessary for read-write support.
#
# Author: Mathias Laurin <mathias_laurin@users.sourceforge.net>
# 2006-11-28, v.0.1.5(4)
# 2009-02-24, v.0.1.6(1) Weedy <weedy2887@gmail.com>
# 2009-03-20, v.0.1.7(1) j0inty <j0inty@stollfuss.net>
# 2009-07-10, v.0.1.8(1) j0inty
# 2009-08-14, v.0.1.9(1) morris <mauricioarozi@gmail.com>
# 2009-09-01. v.0.1.9(1) nall <soir@fuzzysock.net>
# 2009-11-22, v.0.2.0(3) morris <mauricioarozi@gmail.com>
# 2013-05-02, v.0.3.0    lucianm <lucianm@users.sourceforge.net>

#set -x

source /usr/lib/misc/elog-functions.sh
source /etc/portage/squash_portage.conf

retuval() {
	retval=${1}
	eend ${retval}
	[ ${retval} -ne 0 ] && \
	ewarn "${2}" && \
	return 1
}

check_support() {
	if ! [ -x /usr/bin/mksquashfs ] ; then
		eerror "ERROR: sys-fs/squashfs-tools is not installed."
		return 1
	fi
	if ! [ -w /dev/loop0 ] ; then
		eerror "ERROR: loopback support is not available."
		return 1
	fi
	if ! [[ $(grep -s aufs /proc/filesystems) ]] ; then
		eerror "ERROR: aufs filesystem support is not available."
		return 1
	fi
	if ! [[ $(grep -s squashfs /proc/filesystems) ]] ; then
		eerror "ERROR: squashfs filesystem support is not available."
		return 1
	fi
}


sync() {
	source /etc/make.globals		# MUST source inside function, causes initramfs errors otherwise
	source /etc/make.conf
	source /etc/portage/make.conf
	ebegin "Syncing portage tree"
	if [ ${SYNC_CMD} ]; then
		eval ${SYNC_CMD}
	else
		[ -x '/usr/bin/emerge' ] && local SYNC_CMD='command emerge --sync'
		[ -x '/usr/bin/paludis' ] && local SYNC_CMD='command paludis --sync'
		[ -x '/usr/bin/eix' ] && local SYNC_CMD='command eix-sync'
		# make eix-sync work with layman overlays shound't be default
		# [ -x '/usr/bin/eix' ] && [ -x '/usr/bin/layman' ] && [ ! -f /etc/eix-sync.conf ] && `/bin/echo '*' > /etc/eix-sync.conf`

		eval "${SYNC_CMD}"
	fi
	retuval ${?} "Error: ${SYNC_CMD}"
	stop
	start
	eend 0
}

start() {
	source /etc/make.globals	# MUST source inside function
	source /etc/make.conf
	source /etc/portage/make.conf

	ebegin "Mounting read-only squashfs image(s)"
	check_support
	if [ ! -d "${SQFS_DIRNAME}" ]; then
		einfo "${SQFS_DIRNAME} does not exist, creating"
		mkdir -p "${SQFS_DIRNAME}"
		retuval ${?} "Error: mkdir -p ${SQFS_DIRNAME}"
	fi

	for i in ${SQFSS[@]}; do
		einfo "Mounting ${i}"
		mount -rt squashfs -o loop,nodev,noexec "${SQFS_DIRNAME}/sqfs.${i}-current.sqfs" "${SQFS_DIRNAME}/${i}"
		retuval ${?} "Error: mount -rt squashfs -o loop,nodev,noexec \"${SQFS_DIRNAME}/sqfs.${i}-current.sqfs\" \"${SQFS_DIRNAME}/${i}\""
		[ "${SQFS_DIST}" ] || \
		if [ `echo ${DISTDIR} | grep "${SQFS_DIRNAME}/${i}"` ]; then
			mkdir -p /usr/local/distfiles
			retuval ${?} "Error: mkdir -p /usr/local/distfiles"
			mount -o bind "/usr/local/distfiles" "${DISTDIR}"
			retuval ${?} "Error: mount -o bind /usr/local/distfiles ${DISTDIR}"
			ewarn "DISTDIR is currently inside of ${SQFS_DIRNAME}/${i} tree. 
			It has been bind mounted to keep the SquashFS image small."
		fi
	done; unset i rw

	einfo "Mounting read-write with aufs"
	for i in `seq 0 $[${#FSRW[@]}-1]`; do
		local RW=${FSRW[${i}]:-"/dev/shm/.${SQFSS[${i}]}-rw"}
		[ -d "${RW}" ] || einfo "Creating ${RW}" && mkdir -p "${RW}"
		retuval ${?} "Error: mkdir -p \"${RW}\"" 
		chmod 0750 "${RW}"
		retuval ${?} "Error: chmod 0750 \"${RW}\""
		chown portage:portage "${RW}"
		retuval ${?} "Error: chown portage:portage \"${RW}\""
	done; unset a i rw

	for i in ${SQFSS[@]}; do
		[ ${a} ] && a=$[${a}+1] || local a=0
		local RW=${FSRW[${a}]:-"/dev/shm/.${i}-rw"}
		einfo "${RW}"
		mount -t aufs -o "nodev,noexec,br:${RW}=rw:${SQFS_DIRNAME}/${i}=ro" aufs "${SQFS_DIRNAME}/${i}"
		retuval ${?} "Error: mount -t aufs -o \"nodev,noexec,br:${RW}=rw:${SQFS_DIRNAME}/${i}=ro\" aufs \"${SQFS_DIRNAME}/${i}\""
		einfo "${SQFSS[${a}]} mounted in ${RW}"
	done; unset a i rw
	eend ${?}
}

stop() {
	source /etc/make.globals	# MUST source inside function
	source /etc/make.conf
	source /etc/portage/make.conf

	check_support
	if [ "$RC_RUNLEVEL" != shutdown ]; then	# OpenRC timeout doesn't allow this kind of thing
		ebegin "Updating portage tree"
		for i in `seq 0 $[${#FSRW[@]}-1]`; do
			local RW=${FSRW[${i}]:-"/dev/shm/.${SQFSS[${i}]}-rw"}
			einfo "Syncing the tree ${SQFSS[${i}]}"
			if [ ! -z "`/bin/ls -A "${RW}" | /bin/grep -v .wh.`" ]; then
				einfo "Syncing..."
				local SOLD="${SQFS_DIRNAME}/sqfs.${SQFSS[${i}]}-old.sqfs"
				local SNEW="${SQFS_DIRNAME}/sqfs.${SQFSS[${i}]}-current.sqfs"
				local SS="${SQFS_DIRNAME}/sqfs.${SQFSS[${i}]}.sqfs"
				mv -f "${SNEW}" "${SOLD}"
				retuval ${?} "Error: mv -f \"${SNEW}\" \"${SOLD}\""
				[ -w "${SQFS_DIRNAME}" ] && \
				/usr/bin/mksquashfs "${SQFS_DIRNAME}/${SQFSS[${i}]}" "${SNEW}" ${SQFS_OPTS}
				retuval ${?} "Error: /usr/bin/mksquashfs \"${SQFS_DIRNAME}/${SQFSS[${i}]}\" \"${SNEW}\" ${SQFS_OPTS}"
				/bin/ln -fs "${SNEW}" "${SS}"
				retuval ${?} "Error: /bin/ln -fs \"${SNEW}\" \"${SS}\""
			else
				einfo "Nothing to do"
			fi
		done; unset a i retval
	fi

	ebegin "Unmounting the tree(s)"
		for i in ${SQFSS[@]}; do
		[ ${a} ] && a=$[${a}+1] || local a=0
		local RW=${FSRW[${a}]:-"/dev/shm/.${i}-rw"}
				umount -f -l -t aufs "${SQFS_DIRNAME}/${i}"
		retuval ${?} "Error: umount -f -l -t aufs \"${SQFS_DIRNAME}/${i}\""
		umount -f -l -t squashfs "${SQFS_DIRNAME}/${i}"
		retuval ${?} "Error: umount -f -l -t squashfs \"${SQFS_DIRNAME}/${i}\""
		/bin/rm -fr "${RW}"
		retuval ${?} "Error: /bin/rm -fr \"${RW}\""
		done; unset i retval

	eend 0
}

case "${1}" in
	start)
		start
	;;
	stop)
		stop
	;;
	restart)
		stop
		start
	;;
	sync)
		sync
	;;
	*)
		einfo "Usage: ${0} start | stop | restart | sync"
		exit 1
	;;
esac

exit 0
