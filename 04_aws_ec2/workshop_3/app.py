import os,socket
from datetime import datetime,timezone
from flask import Flask,jsonify
app=Flask(__name__)
@app.get("/")
def index(): return jsonify(message="Aplicación desplegada en EC2",container=socket.gethostname(),time=datetime.now(timezone.utc).isoformat(),environment=os.getenv("ENVIRONMENT","lab"))
@app.get("/health")
def health(): return jsonify(status="ok")
