#! /bin/bash

IP=$(ip addr show tap0 | grep "inet "| cut -d " " -f 6)
NET=$(echo $IP | cut -d "." -f 1-2)
RANGE=$(echo $IP | cut -d "/" -f 2)
SUB=$(echo $IP | cut -d "." -f 3)

myloop(){
	for i in `seq 0 255`;
	do
		ping -qnLc 1 -W 1 "$NET.$SUB.$i"
	done
}

myloop

if [ $RANGE == "23" ];
then 
	let "SUB += 1"
	myloop
fi

