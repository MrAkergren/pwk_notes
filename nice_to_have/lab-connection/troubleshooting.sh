#!/bin/bash
## Last updated: 2014-11-27


## Notice
echo -e '\e[01;36m[+]\e[00m Please send the following (along with the output from the OpenVPN window),\n    with your OSID to "help@offensive-security.com"'
echo ""


## Network interfaces
echo -e '\e[01;33m[i]\e[00m Network Interfaces'
ifconfig   #ifconfig -a
sleep 3
echo ""


## Network routes
echo -e '\e[01;33m[i]\e[00m Network Routes'
route -n
sleep 3
echo ""


## DNS information
echo -e '\e[01;33m[i]\e[00m DNS Information'
cat /etc/resolv.conf
sleep 3
echo ""


## Ping test
echo -e '\e[01;33m[i]\e[00m Ping Test'
ping -c 4 www.google.com
[[ $? != '0' ]] && echo -e '\e[01;31m[!]\e[00m Ping test failed.\n\e[01;31m[!]\e[00m Please make sure you have Internet access.'
sleep 3
echo ""


## UDP port test
echo -e '\e[01;33m[i]\e[00m UDP Port Test'
[[ ! -e lab-connection.conf ]] && echo -e '\e[01;31m[!]\e[00m Missing connection pack'
ip=$(grep -e '^remote ' lab-connection.conf 2> /dev/null | awk '{print $2}')
nc -vnzu $ip 1194
[[ $? != '0' ]] && echo -e '\e[01;31m[!]\e[00m UDP port test failed.\n\e[01;31m[!]\e[00m Please make sure you can do outbound UDP connections to 1194.\n\e[01;31m[!]\e[00m You may need to get in touch with your network administrator.'
sleep 3
echo ""


## Checking kernel
echo -e '\e[01;33m[i]\e[00m Checking Kernel Version'
uname -a
sleep 1
echo ""


## Checking OS
echo -e '\e[01;33m[i]\e[00m Checking OS'
cat /etc/issue
cat /etc/*-release
sleep 1
echo ""


## Notice
echo -e '\e[01;36m[+]\e[00m Test complete.'
echo -e '\e[01;36m[+]\e[00m Please send the above output to "help@offensive-security.com" \n    with your OSID & OpenVPN connection output'
echo ""
