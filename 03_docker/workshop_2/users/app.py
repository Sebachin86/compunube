from flask import Flask, jsonify
app=Flask(__name__)
@app.get("/")
def index(): return jsonify(service="users",data=[{"id":1,"name":"Ana"},{"id":2,"name":"Luis"}])
@app.get("/health")
def health(): return jsonify(status="ok",service="users")
