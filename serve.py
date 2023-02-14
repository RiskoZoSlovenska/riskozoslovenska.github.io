#!/usr/bin/env python
# Custom serving script used for development
# Sends a no-cache header and (very dumbly) tries to resolve missing .html extensions
# Taken from https://stackoverflow.com/a/13354482 and https://stackoverflow.com/a/73029002

from http import server
import re

class MyHTTPRequestHandler(server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_my_headers()

        server.SimpleHTTPRequestHandler.end_headers(self)

    def send_my_headers(self):
        self.send_header("Cache-Control", "no-cache")
    
    def do_GET(self):
        if not re.search("\.(html|xhtml|js|mjs|css|json|yaml|txt|md|lua|png|svg|jpg|jpeg|ico)|/$", self.path):
            print("Appending extension for path: " + self.path)
            self.path += ".html"

        return server.SimpleHTTPRequestHandler.do_GET(self)


if __name__ == '__main__':
    server.test(HandlerClass=MyHTTPRequestHandler)