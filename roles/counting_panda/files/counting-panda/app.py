import os
from flask import Flask, Response

app = Flask(__name__)
# ____________________

@app.route("/",methods=["GET"], defaults={'path':''} )
@app.route("/<path:path>", methods=['GET'])
def count_requests(path):
    SITE_ROOT = os.path.realpath(os.path.dirname(__file__))
    counter_file = os.path.join(SITE_ROOT, 'counter.txt')

    with open(counter_file, "r+") as f:
        old_count = f.read()
        new_count = int(old_count) + 1
        f.seek(0)
        f.write(str(new_count))
        f.truncate()

    return Response(response="Path was: %s. Number of GET requests so far: %d" % (path, new_count), status=200)
# ____________________

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9292,debug=False)
