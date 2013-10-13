#!/bin/sh
#
# Run the init.d scripts for services in our pseudo runlevel in ``${SERVICES_RUNLEVEL}''

source /etc/conf.d/NetworkManagerDispatcher

if [ -z "${SERVICES_RUNLEVEL}" ]; then
        echo "SERVICES_RUNLEVEL not set, cannot continue!"
        exit 1
fi

for name in $(find /etc/runlevels/${SERVICES_RUNLEVEL} -executable -type l); do
        $name status | grep -q "started"

        if test "$2" == "up" -a "$?" != "0"; then
                rc-config start $(basename $name) &
        else
                rc-config stop $(basename $name) &
        fi
done

