#! /usr/bin/env python3
import os
import re

op = os.popen('ip addr show tap0 | grep "inet "| cut -d " " -f 6')
ip = op.read()

net_l = re.findall('\d+',ip)
sub = ip[-3:]
print(net_l)
def myloop():
    for i in range(0,256):
        os.system("ping -qnLc 1 -W 1 " + net_l[0]+"."+net_l[1]+"."+str(net_l[2])+"."+str(i))
myloop()
if(23 == int(sub)):
        net_l[2] = int(net_l[2]) + 1
        myloop()

