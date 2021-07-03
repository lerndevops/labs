from flask import Flask, redirect, url_for, render_template, request
import json, sys, requests, os, ssl, urllib2, base64, time, io
import socket
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from pprint import pprint

app = Flask(__name__)
app.debug = True

@app.route('/')

def gethname():
    return socket.gethostname()

if __name__ == '__main__':
         app.run(host='0.0.0.0', port=3000)
