#!/usr/bin/env python
# Custom serving script used for development
# Sends a no-cache header and resolves missing .html extensions
# Taken from https://stackoverflow.com/a/13354482 and https://stackoverflow.com/a/73029002

from http import server
from os.path import splitext

class MyHTTPRequestHandler(server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs): # https://stackoverflow.com/a/52531444
        super().__init__(*args, directory="build", **kwargs)

    def end_headers(self):
        self.send_header("Cache-Control", "no-cache")

        server.SimpleHTTPRequestHandler.end_headers(self)

    def do_GET(self):
        if not self.path.endswith("/") and splitext(self.path)[1] == "":
            print("Appending extension for path: " + self.path)
            self.path += ".html"

        return server.SimpleHTTPRequestHandler.do_GET(self)


if __name__ == "__main__":
    server.test(HandlerClass=MyHTTPRequestHandler)
