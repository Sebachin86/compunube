import os, socket
from flask import Flask, jsonify, request
import psycopg
app=Flask(__name__)
def conn(): return psycopg.connect(host=os.getenv("DB_HOST","db"),dbname=os.getenv("DB_NAME","lab"),user=os.getenv("DB_USER","lab"),password=os.getenv("DB_PASSWORD","labpass"))
@app.get("/health")
def health():
 try:
  with conn() as c: c.execute("SELECT 1")
  return jsonify(status="ok",db="ok")
 except Exception: return jsonify(status="error"),503
@app.get("/products")
def products():
 with conn() as c: rows=c.execute("SELECT id,name,price FROM products ORDER BY id").fetchall()
 return jsonify(served_by=os.getenv("INSTANCE_NAME",socket.gethostname()),products=[{"id":r[0],"name":r[1],"price":float(r[2])} for r in rows])
@app.post("/products")
def add():
 d=request.get_json(force=True)
 if not d.get("name") or d.get("price") is None: return jsonify(error="name y price requeridos"),400
 with conn() as c: r=c.execute("INSERT INTO products(name,price) VALUES(%s,%s) RETURNING id,name,price",(d["name"],d["price"])).fetchone()
 return jsonify(id=r[0],name=r[1],price=float(r[2])),201
