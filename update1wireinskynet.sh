#!/bin/bash
#
# target is a raspberry
#
ONEWIRE=/mnt/1wire
SKYNET=http://localhost:3000/devices

#set -x
token=baggis
for dev in $@ ; do
	family=`cat $dev/family`
	id=`cat $dev/id`

	if [ -f $dev/temperature ] ; then
		value=`cat $dev/temperature`
	elif [ -f $dev/counters.ALL ] ; then
		value=`cat $dev/counters.ALL`
	fi
	
	uuid=${family}.${id}
	args="token=${token}&value=${value}"

	curl -X PUT -d "${args}" ${SKYNET}/${uuid}
done
