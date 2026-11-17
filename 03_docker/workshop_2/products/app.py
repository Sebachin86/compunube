from flask import Flask, jsonify
app=Flask(__name__)
@app.get("/")
def index(): return jsonify(service="products",data=[{"id":1,"name":"Laptop"},{"id":2,"name":"Mouse"}])
@app.get("/health")
def health(): return jsonify(status="ok",service="products")
