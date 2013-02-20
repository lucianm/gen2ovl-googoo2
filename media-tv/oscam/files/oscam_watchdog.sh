#!/bin/bash
#
# Watchdog for OSCAM by 3PO

#set -x

# read variables
source /etc/conf.d/oscam


LOGDIR="/var/log/oscam"
LOGFILE="oscam_watchdog.log"
EXITLOG="$LOGDIR/exitlog_$(date +%F_%R).log"
OSCAMLOG="$LOGDIR/oscam.log"


[ ! -d "$LOGDIR" ] && mkdir $LOGDIR
LOG="${LOGDIR}/${LOGFILE}"

sleep 10

while sleep $CHECKTIME
do
	PID=`pidof $DAEMON`
	if [ -z "$PID" ] ; then
		echo "$(date) Error, ${DESCRIPTION} is not running" >> $LOG
		echo "$(date) Restarting ${DESCRIPTION} ..." >> $LOG
		tail -n50 $OSCAMLOG > $EXITLOG
		/etc/init.d/$DAEMON restart
		PID=`pidof $DAEMON`
		if [ -z "$PID" ] ; then
			echo "$(date) Error, while restarting ${DESCRIPTION}" >> $LOG
		else
			echo "$(date) ${DESCRIPTION} restarted" >> $LOG
		fi
	fi
done

exit 0
