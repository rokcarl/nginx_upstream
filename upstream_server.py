import time
from bottle import route, run, template

@route('/sleep')
@route('/sleep/')
def sleep():
    time.sleep(12)
    return 'Hello after sleep.'

@route('/')
def index():
    return 'Upstream server.'

run(host='0.0.0.0', port=80)
