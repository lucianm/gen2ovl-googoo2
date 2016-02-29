#!/bin/bash
#
# Watchdog for OSCAM

#set -x

# read variables
source /etc/conf.d/oscam
# check if already running
if [ "$(pidof -x "$0" -o $$ -o $PPID -o %PPID)" != "" ] ; then
   logger -s "ERROR: $0 laeuft bereits"
   exit
fi
LOGDIR="/var/log/oscam"
LOGFILE="oscam_watchdog.log"
EXITLOG="$LOGDIR/exitlog_$(date +%F_%R).log"
OSCAMLOG="$LOGDIR/oscam.log"

[ ! -d "$LOGDIR" ] && mkdir -p $LOGDIR
LOG="${LOGDIR}/${LOGFILE}"

while [ 1 ] ; do
   ${OSCAM_DAEMON} ${OSCAM_OPTS}
   echo "$(date) Error, ${DESCRIPTION} stopped" >> $LOG
   echo "$(date) Restarting ${DESCRIPTION} ..." >> $LOG
   tail -n50 $OSCAMLOG > $EXITLOG
   sleep 3
done

exit 0
