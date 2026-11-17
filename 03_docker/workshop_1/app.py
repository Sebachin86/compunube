import os, socket
from flask import Flask, jsonify
app=Flask(__name__)
@app.get("/")
def home(): return jsonify(message="API balanceada",served_by=os.getenv("INSTANCE_NAME",socket.gethostname()))
@app.get("/health")
def health(): return jsonify(status="ok")
