import socket
import sys

try:
    port = int(sys.argv[1])
except:
    print 'Usage: ./readiness.py <Port>'
    sys.exit(1)

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = (socket.gethostname(), str(port))
sock.bind(server_address)

# Listen for incoming connections
sock.listen(1)

while True:
    connection, client_address = sock.accept()