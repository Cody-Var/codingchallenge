import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
#Have fixed the code as previously it has issues with main function
def main():
    return "Hello Afterpay!"


if __name__ == "__main__":
    app.run()
