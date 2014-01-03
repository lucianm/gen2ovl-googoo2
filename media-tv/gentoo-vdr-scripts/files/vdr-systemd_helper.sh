#!/bin/bash

# VDR helper script for using a systemd unit together
# with media-tv/gentoo-vdr-scripts
#
# Copyright 2011-2014, Lucian Muresan < lucianm AT users DOT sourceforge DOT net >
# inspired by the old OpenRC script /etc/init.d/vdr by Mathias Schwarzott

# Distributed under the terms of the GNU General Public License v2

# read our main options
. /etc/conf.d/vdr
. /etc/conf.d/vdr.watchdogd

# dummy functions to make the rest of gentoo-vdr-scripts happy,
# as we do not want to rely on openrc's implementations of these
# commands:
ebegin() {
	vdr_log "ACTION:$@"
}

eend() {
	vdr_log "RESULT:  $@"
}

ewarn() {
	vdr_log "WARN:   $@"
}

einfo() {
	vdr_log "INFO:     $@"
}

# inspired by the old OpenRC script /etc/init.d/vdr:
common_init() {
	cd ${HOME}
	unset MAIL
	. /usr/share/vdr/inc/functions.sh
	include rc-functions
	include plugin-functions
	VDR_LOG_FILE=/var/vdr/tmp/vdr-start-log
	# this is the environment file to pass user and parameters to the systemd unit file
	SYSTEMD_ENV_FILE=/var/vdr/tmp/systemd_env
	# determine under which of 'vdr' and 'root' users to run the actual systemd service, too
	vdr_user=vdr
	yesno ${START_VDR_AS_ROOT} && vdr_user=root
}

clear_logfile() {
	rm -f "${VDR_LOG_FILE}"
	printf "" > "${VDR_LOG_FILE}"
}

#
# Used to log error-messages in startscript to show them on
# OSD later when choosing apropriate point in commands.
#

vdr_log()
{
	echo "$@" >> ${VDR_LOG_FILE}
}

#
#
# Depending on $1, we execute the scripts needed
# before/after starting, or before/after stopping VDR:
if [ "$1" = "--start-pre" ]; then
	common_init
	clear_logfile
	init_params
	init_plugin_loader start
	load_addons_prefixed pre-start || return 1
	# these options are what we need to start VDR from the
	# systemd unit file(s)
	echo "VDR_USER=\"${vdr_user}\"" > ${SYSTEMD_ENV_FILE}
	echo "VDR_OPTS=\"${vdr_opts}\"" >> ${SYSTEMD_ENV_FILE}
	sync
	# this will ensure that systemd will actually parse our
	# new version of EnvironmentFile before starting VDR
	# otherwise it might not work correctly, this part is called
	# by the wrapper unit as root, anyway:
	/bin/systemctl --system daemon-reload
elif [ "$1" = "--start-post" ]; then
	common_init
	#init_plugin_loader start
	load_addons_prefixed post-start
elif [ "$1" = "--stop-pre" ]; then
	common_init
	init_plugin_loader stop
	load_addons_prefixed pre-stop
elif [ "$1" = "--stop-post" ]; then
	common_init
	#init_plugin_loader stop
	load_addons_prefixed post-stop
fi
