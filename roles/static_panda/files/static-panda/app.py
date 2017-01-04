from flask import Flask, Response
from flask import send_from_directory

app = Flask(__name__, static_url_path='/resources/')

# ____________________

@app.route("/",methods=["GET"])
def index():
    return Response(response="Hello Mr. Panda!",status=200)
# ____________________

@app.route("/medium-panda/",methods=["GET"])
def big_panda():
    return send_from_directory('resources', 'medium.png')

# ____________________

@app.route("/small-panda/",methods=["GET"])
def small_panda():
    return send_from_directory('resources', 'small.png')

# ____________________

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9191,debug=False)
