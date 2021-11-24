import flask
import json
import random

# load the json file from directory and opens it
jsonfile = json.load(open('task.json', encoding="utf-8"))

# locate a specific array and randomly pick one
def randomizeOutput():
    x = random.choice(jsonfile ["task"]["motivation"])
    return x["daily"]

# configuration for non-english characters, debugging and interprets flask module
app = flask.Flask(__name__)
app.config["DECODE"] = "utf-8"
app.config["DEBUG"] = True

# URL of the output
@app.route("/getTask", methods=["GET"])

# function that dumps the output of the randomly picked array from before
def getTask():
    
    return json.dumps(randomizeOutput(), ensure_ascii=False)

# runs localhost
app.run(host = "0.0.0.0", port = 8080)