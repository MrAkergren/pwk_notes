#! /bin/bash

IP=$(ip addr show eth0 | grep "inet " | cut -d " " -f 6)

NET=$(echo $IP | cut -d "." -f 1-3)
SUB=$(echo $IP | cut -d "/" -f 2)

echo Your IP and subnet is $IP
echo Trying to ping the $NET.0 net with the sub 24
echo " " 

if [ "$SUB" == "24" ]
then
	for i in `seq 0 4`;
	do 
		ping -nqc 1 $NET.$i
	done
else
	echo "error wrong subnet"
fi
