#!/usr/bin/env python
import os
import requests
import json
import subprocess
from urlparse import urlsplit,urlunsplit
from flask import Flask
from flask import request
from flask import Response
from flask import jsonify

app = Flask(__name__)

# set this to either ephmeral or in_channel
response_setting = "ephemeral"

# sanitize input for unicode
_u = lambda t: t.decode('UTF-8', 'replace') if isinstance(t, str) else t

@app.route('/getdkp', methods = ['GET', 'POST'])
def getdkp():
    if request.method == 'GET':
        request_data = request.get_data()
        # if you want to use GET put stuff here
        return "this is a GET request"

    if request.method == 'POST':
        tokens = request.values.get('text').strip().split()
        dkp_name = tokens[0]
        # shell tool that scrapes EQDKP-Plus points page
        playerproc = subprocess.Popen(["sh","./report-dkp-slashcommand.sh", dkp_name],
                                      stdout=subprocess.PIPE)
        playerout = playerproc.stdout.read().strip()
        response_dict = { "response_type": response_setting, "text": playerout }
        return Response(json.dumps(response_dict), mimetype="application/json")
    else:
        return "405 Method Not Allowed"

@app.route('/')
def root():
    """
    Home handler
    """
    return "OK"

# Python wsgi server options
if __name__ == "__main__":
    port = int(os.environ.get('MATTERMOST_DKP_PORT', 8089))
    # use 0.0.0.0 if it shall be accessible from outside of host
    app.run(host='127.0.0.1', port=port)
