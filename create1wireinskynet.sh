#!/bin/bash
#
# target is a raspberry
#
ONEWIRE=/mnt/1wire
SKYNET=http://localhost:3000/devices

#set -x
token=baggis
for dev in ${ONEWIRE}/1* ; do
	family=`cat $dev/family`
	id=`cat $dev/id`
	devtype=`cat $dev/type`

	if [ -f $dev/temperature ] ; then
		function="temperature"
	elif [ -f $dev/counters.ALL ] ; then
		function="counter"
	fi

	args="uuid=${family}.${id}&devicetype=${devtype}&function=${function}&token=${token}"

	curl -X POST -d "${args}" ${SKYNET}
done
