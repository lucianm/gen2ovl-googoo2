# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdteletext/files/rc-addon-v3.sh,v 1.2 2014/03/03 15:07:36 hd_brummy Exp $
#
# rc-addon-script for plugin osdteletext
#
# Joerg Bornkessel <hd_brummy@gentoo.org>
# Matthias Schwarzott <zzam@gentoo.org>

# this is from /etc/conf.d/vdr.sodteletext, as always
: ${OSDTELETEXT_TMPFS:=yes}

# read from /etc/vdr/conf.avail/osdteletext.conf if the proper g-v-s installed:
argsdir_funcs="/usr/share/vdr/inc/argsdir-functions.sh"
if [ -f "${argsdir_funcs}" ]; then
	source ${argsdir_funcs}
	OSDTELETEXT_DIR="$(get_cfg_opt osdteletext --directory -d)"
	OSDTELETEXT_SIZE="$(get_cfg_opt osdteletext --max-cache -n)"
	[ is_cfg_opt_on osdteletext --toptext -t ] && OSDTELETEXT_STORETOPTEXT="yes"
fi

# if still reading /etc/conf.d/vdr.sodteletext
: ${OSDTELETEXT_SIZE:=20}
: ${OSDTELETEXT_DIR:=/var/cache/vdr/plugins/osdteletext}
: ${OSDTELETEXT_STORETOPTEXT:=no}

# depends on QA, create paths in /var/cache on the fly at runtime as needed
init_cache_dir() {
	if [ ! -d "${OSDTELETEXT_DIR}" ]; then
		mkdir -p ${OSDTELETEXT_DIR}
		chown vdr:vdr ${OSDTELETEXT_DIR}
	fi
}

plugin_pre_vdr_start() {
	init_cache_dir

	add_plugin_param "-d ${OSDTELETEXT_DIR}"
	add_plugin_param "-n ${OSDTELETEXT_SIZE}"

	if [ "${OSDTELETEXT_STORETOPTEXT}" = "yes" ]; then
		add_plugin_param "-t"
	fi

	if [ "${OSDTELETEXT_TMPFS}" = "yes" ]; then
		## test on mountet TMPFS
		if /bin/mount | /bin/grep -q ${OSDTELETEXT_DIR} ; then
			:
		else
			einfo_level2 mounting videotext dir ${OSDTELETEXT_DIR}
			sudo /bin/mount -t tmpfs -o size=${OSDTELETEXT_SIZE}m,uid=vdr,gid=vdr tmpfs ${OSDTELETEXT_DIR}
		fi
	fi
}

plugin_post_vdr_stop() {
	if [ "${OSDTELETEXT_TMPFS}" = "yes" ]; then
		if /bin/mount | /bin/grep -q ${OSDTELETEXT_DIR} ; then
			einfo_level2 unmounting videotext dir ${OSDTELETEXT_DIR}
			sudo /bin/umount ${OSDTELETEXT_DIR}
		fi
	fi
}
