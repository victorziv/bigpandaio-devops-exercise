from flask import Flask, Response
from flask import Flask, request, send_from_directory
app = Flask(__name__, static_url_path='/resources/')

@app.route("/",methods=["GET"])
def index():
    return Response(response="Hello World!",status=200)

@app.route("/big-panda/",methods=["GET"])
def big_panda():
    return send_from_directory('resources', 'panda-big.jpg')

if __name__ == '__main__':
    app.run(port=8080,debug=True)
