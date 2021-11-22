import flask

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/getTask', methods=['GET'])
def home():
    return "hej"

app.run(host='0.0.0.0', port=8080)