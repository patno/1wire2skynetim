#!/bin/bash
#
# target is a raspberry
#
1WIRE=/mnt/1wire
SKYNET=http://localhost:3000/devices

#set -x

for dev in $1WIRE/1* ; do
	family=`cat $dev/family`
	id=`cat $dev/id`
	devtype=`cat $dev/type`

	if -f $dev/temperature ; then
		function="temperature"
	elif -f $dev/counters.ALL ; then
		function="counter"		
	fi
	
	args='"uuid=${family}.${if}&devicetype=${devtype}&function=${function}"'

	echo $args

done