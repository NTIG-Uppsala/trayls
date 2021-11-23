import flask
import json
from random import randrange

jsonfile = json.load(open('task.json', encoding="utf-8"))

def randomizeOutput():
    x = randrange(0, 3)
    return jsonfile["task"]["motivation"][x]

app = flask.Flask(__name__)
app.config["DECODE"] = "utf-8"
app.config["DEBUG"] = True

@app.route("/getTask", methods=["GET"])

def home():
    return json.dumps(randomizeOutput(), ensure_ascii=False)

app.run(host = "0.0.0.0", port = 8080)