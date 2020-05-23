import BaseHTTPServer
import sys

class RequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    Response = "OK"
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.send_header("Content-Length", str(len(self.Response)))
        self.end_headers()
        self.wfile.write(self.Response)

if __name__ == '__main__':
    try:
        port = int(sys.argv[1])
    except:
        print 'Usage: ./readiness.py <Port>'
        sys.exit(1)

    serverAddress = ('', port)
    server = BaseHTTPServer.HTTPServer(serverAddress, RequestHandler)
    print ('Listerning: http://localhost:' + str(port))
    server.serve_forever()
