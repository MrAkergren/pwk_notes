#!/bin/bash
## Offensive-Security's troubleshooting script
## Last updated: 2016-01-20


## Bash colours
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
BOLD="\033[01;01m"
RED="\033[01;31m"
RESET="\033[00m"


## Banner/Notice
echo -e "\n${BLUE}[+]${RESET} Please ${BOLD}send the log file 'troubleshoot.log'${RESET} along with the ${BOLD}output from the OpenVPN window${RESET}), with ${BOLD}your OSID${RESET} to '${BOLD}help@offensive-security.com${RESET}'."
sleep 3s


## Date
echo -e "\n\n${YELLOW}[i]${RESET} Date"
echo "[i] Date" > troubleshoot.log
date | tee -a troubleshoot.log
sleep 3s


## VM check
echo -e "\n\n${YELLOW}[i]${RESET} Virtual Machine Check"
echo -e "\n\n[i] Virtual Machine Check" >> troubleshoot.log
if (dmidecode | grep -iq vmware); then
  echo -e "VMware Detected" | tee -a troubleshoot.log
elif (dmidecode | grep -iq virtualbox); then
  echo -e "VirtualBox Detected! It is highly recommended that all students use the VMware student VM." | tee -a troubleshoot.log
else
  echo "VM not detected! It is highly recommended that all students use the student VM." >> troubleshoot.log
  echo -e "${RED}VM not detected${RESET} "
fi
sleep 3s


## Network interfaces
echo -e "\n\n${YELLOW}[i]${RESET} Network Interfaces"
echo -e "\n\n[i] Network Interfaces" >> troubleshoot.log
ifconfig | tee -a troubleshoot.log   #ifconfig -a
sleep 3s


## Network routes
echo -e "\n\n${YELLOW}[i]${RESET} Network Routes"
echo -e "\n\n[i] Network Routes" >> troubleshoot.log
route -n | tee -a troubleshoot.log
sleep 3s


## DNS information
echo -e "\n\n${YELLOW}[i]${RESET} DNS Information"
echo -e "\n\n[i] DNS Information" >> troubleshoot.log
cat /etc/resolv.conf | tee -a troubleshoot.log
sleep 3s


## Ping test
echo -e "\n\n${YELLOW}[i]${RESET} Ping Test"
echo -e "\n\n[i] Ping Test" >> troubleshoot.log
ping -c 4 8.8.8.8 | tee -a troubleshoot.log
[[ $? != '0' ]] && echo -e "\n\n${RED}[!]${RESET} Ping test failed (8.8.8.8).\n${RED}[!]${RESET} Please make sure you have Internet access."
ping -c 4 www.google.com | tee -a troubleshoot.log
[[ $? != '0' ]] && echo -e "\n\n${RED}[!]${RESET} Ping test failed (www.google.com)..\n${RED}[!]${RESET} Please make sure you have Internet access."
sleep 3s


## External IP
echo -e "\n\n${YELLOW}[i]${RESET} External IP"
echo -e "\n\n[i] External IP" >> troubleshoot.log
curl -s http://ipinfo.io/ip | tee -a troubleshoot.log
sleep 3s


## UDP port test
echo -e "\n\n${YELLOW}[i]${RESET} UDP Port Test"
echo -e "\n\n[i] UDP Port Test" >> troubleshoot.log
if [[ -e lab-connection.conf ]]; then
  IP=$(grep -e '^remote ' lab-connection.conf | awk '{print $2}')
  nc -vnzu ${IP} 1194 | tee -a troubleshoot.log
else
  echo "Missing connection pack" >> troubleshoot.log
  ls -lah >> troubleshoot.log
  echo -e "\n\n${RED}[!]${RESET} Missing connection pack"
fi
sleep 3s


## Checking user
echo -e "\n\n${YELLOW}[i]${RESET} Checking User"
echo -e "\n\n[i] User" >> troubleshoot.log
id | tee -a troubleshoot.log
sleep 1s


## Checking kernel version
echo -e "\n\n${YELLOW}[i]${RESET} Checking Kernel Version"
echo -e "\n\n[i] Checking Kernel Version" >> troubleshoot.log
uname -a | tee -a troubleshoot.log
sleep 1s


## Checking OS
echo -e "\n\n${YELLOW}[i]${RESET} Checking OS"
echo -e "\n\n[i] Checking OS" >> troubleshoot.log
cat /etc/issue | tee -a troubleshoot.log
cat /etc/*-release | tee -a troubleshoot.log
sleep 1s


## Notice
echo -e "\n\n${BLUE}[+]${RESET} Test complete."
echo -e "${BLUE}[+]${RESET} Please ${BOLD}send the log file 'troubleshoot.log' to 'help@offensive-security.com'${RESET} with your ${BOLD}OSID${RESET} & ${BOLD}OpenVPN connection output window${RESET}.\n"
sleep 1s
