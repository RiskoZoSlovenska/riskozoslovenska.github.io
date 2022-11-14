#!/usr/bin/env python
# Taken from https://stackoverflow.com/a/13354482, used for testing on mobile

try:
    from http import server # Python 3
except ImportError:
    import SimpleHTTPServer as server # Python 2

class MyHTTPRequestHandler(server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_my_headers()

        server.SimpleHTTPRequestHandler.end_headers(self)

    def send_my_headers(self):
        self.send_header("Cache-Control", "no-cache")


if __name__ == '__main__':
    server.test(HandlerClass=MyHTTPRequestHandler)