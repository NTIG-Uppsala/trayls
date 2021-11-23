import flask
import json

jsonfile = json.load(open('task.json', encoding="utf-8"))

def randomizeOutput():
    return jsonfile["task"]["motivation"][1]

app = flask.Flask(__name__)
app.config["DECODE"] = "utf-8"
app.config["DEBUG"] = True

@app.route("/getTask", methods=["GET"])

def home():
    return json.dumps(randomizeOutput(), ensure_ascii=False)

app.run(host = "0.0.0.0", port = 8080)