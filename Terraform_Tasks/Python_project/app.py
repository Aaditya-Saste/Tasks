from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, Terraform! This simple python project is hosted by using terraform provisioner block without adding user data (Zero human touch Automation)"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)