#! /bin/bash

echo "# eth0 conf
auto eth0
allow-hotplug eth0
iface eth0 inet dhcp" >> /etc/network/interfaces
