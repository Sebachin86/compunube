import os
from datetime import date
from decimal import Decimal
from flask import Flask, jsonify, request
import psycopg
from psycopg.rows import dict_row

app = Flask(__name__)
DATABASE_URL = os.environ.get("DATABASE_URL", "postgresql://equipment:equipment@db:5432/equipment")

def db():
    return psycopg.connect(DATABASE_URL, row_factory=dict_row)

def clean(rows):
    result = []
    for row in rows:
        item = dict(row)
        for key, value in item.items():
            if isinstance(value, Decimal): item[key] = float(value)
            elif isinstance(value, date): item[key] = value.isoformat()
        result.append(item)
    return result

@app.get("/health")
def health():
    try:
        with db() as conn: conn.execute("SELECT 1")
        return jsonify(status="ok", database="ok")
    except Exception:
        app.logger.exception("Health check failed")
        return jsonify(status="error", database="unavailable"), 503

@app.get("/empleados")
def employees():
    with db() as conn:
        rows = conn.execute("SELECT id,name,email,department FROM employees ORDER BY id").fetchall()
    return jsonify(clean(rows))

@app.post("/empleados")
def create_employee():
    data = request.get_json(silent=True) or {}
    if not data.get("nombre") or not data.get("correo"):
        return jsonify(error="nombre y correo son obligatorios"), 400
    try:
        with db() as conn:
            row = conn.execute("INSERT INTO employees(name,email,department) VALUES(%s,%s,%s) RETURNING id,name,email,department",
                (data["nombre"],data["correo"],data.get("departamento"))).fetchone()
        return jsonify(clean([row])[0]), 201
    except psycopg.errors.UniqueViolation:
        return jsonify(error="El correo ya existe"), 409

@app.get("/empleados/<int:item_id>")
def get_employee(item_id):
    with db() as conn:
        row = conn.execute("SELECT id,name,email,department FROM employees WHERE id=%s",(item_id,)).fetchone()
    return (jsonify(clean([row])[0]),200) if row else (jsonify(error="Empleado no encontrado"),404)

@app.get("/equipos")
def equipment():
    with db() as conn:
        rows = conn.execute("""SELECT e.id,e.internal_code,e.type,e.brand,e.model,e.serial_number,e.status,
        e.acquisition_date,e.employee_id,emp.name AS employee_name FROM equipment e
        LEFT JOIN employees emp ON emp.id=e.employee_id ORDER BY e.id""").fetchall()
    return jsonify(clean(rows))

@app.post("/equipos")
def create_equipment():
    d = request.get_json(silent=True) or {}
    if not d.get("codigo_interno") or not d.get("tipo"):
        return jsonify(error="codigo_interno y tipo son obligatorios"),400
    try:
        with db() as conn:
            row=conn.execute("""INSERT INTO equipment(internal_code,type,brand,model,serial_number,status,acquisition_date)
            VALUES(%s,%s,%s,%s,%s,%s,%s) RETURNING *""",
            (d["codigo_interno"],d["tipo"],d.get("marca"),d.get("modelo"),d.get("numero_serie"),
             d.get("estado","DISPONIBLE"),d.get("fecha_adquisicion"))).fetchone()
        return jsonify(clean([row])[0]),201
    except psycopg.errors.UniqueViolation:
        return jsonify(error="Código o serie duplicados"),409

@app.get("/equipos/<int:item_id>")
def get_equipment(item_id):
    with db() as conn: row=conn.execute("SELECT * FROM equipment WHERE id=%s",(item_id,)).fetchone()
    return (jsonify(clean([row])[0]),200) if row else (jsonify(error="Equipo no encontrado"),404)

@app.put("/equipos/<int:item_id>")
def update_equipment(item_id):
    d=request.get_json(silent=True) or {}
    allowed={"marca":"brand","modelo":"model","estado":"status","tipo":"type"}
    fields=[(col,d[key]) for key,col in allowed.items() if key in d]
    if not fields: return jsonify(error="No hay campos editables"),400
    sql=", ".join(f"{col}=%s" for col,_ in fields)
    with db() as conn:
        row=conn.execute(f"UPDATE equipment SET {sql} WHERE id=%s RETURNING *",[v for _,v in fields]+[item_id]).fetchone()
    return (jsonify(clean([row])[0]),200) if row else (jsonify(error="Equipo no encontrado"),404)

@app.post("/equipos/<int:item_id>/asignar")
def assign(item_id):
    d=request.get_json(silent=True) or {}
    employee_id=d.get("empleado_id")
    if not employee_id: return jsonify(error="empleado_id requerido"),400
    with db() as conn:
        equipment=conn.execute("SELECT status FROM equipment WHERE id=%s FOR UPDATE",(item_id,)).fetchone()
        employee=conn.execute("SELECT id FROM employees WHERE id=%s",(employee_id,)).fetchone()
        if not equipment: return jsonify(error="Equipo no encontrado"),404
        if not employee: return jsonify(error="Empleado no encontrado"),404
        if equipment["status"]!="DISPONIBLE": return jsonify(error="Equipo no disponible"),409
        row=conn.execute("UPDATE equipment SET employee_id=%s,status='ASIGNADO' WHERE id=%s RETURNING *",(employee_id,item_id)).fetchone()
        conn.execute("INSERT INTO equipment_events(equipment_id,event_type,details) VALUES(%s,'ASIGNACION',%s)",(item_id,f"Asignado al empleado {employee_id}"))
    return jsonify(clean([row])[0])

@app.post("/equipos/<int:item_id>/mantenimientos")
def maintenance(item_id):
    d=request.get_json(silent=True) or {}
    if not d.get("tipo") or not d.get("descripcion"): return jsonify(error="tipo y descripcion requeridos"),400
    with db() as conn:
        if not conn.execute("SELECT id FROM equipment WHERE id=%s",(item_id,)).fetchone():
            return jsonify(error="Equipo no encontrado"),404
        row=conn.execute("""INSERT INTO maintenance(equipment_id,type,description,cost)
        VALUES(%s,%s,%s,%s) RETURNING *""",(item_id,d["tipo"],d["descripcion"],d.get("costo",0))).fetchone()
        conn.execute("INSERT INTO equipment_events(equipment_id,event_type,details) VALUES(%s,'MANTENIMIENTO',%s)",(item_id,d["descripcion"]))
    return jsonify(clean([row])[0]),201

@app.get("/equipos/<int:item_id>/historial")
def history(item_id):
    with db() as conn:
        equipment=conn.execute("SELECT internal_code FROM equipment WHERE id=%s",(item_id,)).fetchone()
        if not equipment: return jsonify(error="Equipo no encontrado"),404
        events=conn.execute("SELECT event_type AS evento,details AS detalle,created_at AS fecha FROM equipment_events WHERE equipment_id=%s ORDER BY created_at",(item_id,)).fetchall()
        maint=conn.execute("SELECT 'MANTENIMIENTO' AS evento,description AS detalle,maintenance_date AS fecha FROM maintenance WHERE equipment_id=%s ORDER BY maintenance_date",(item_id,)).fetchall()
    return jsonify(equipo=equipment["internal_code"],historial=clean(events+maint))

@app.post("/equipos/<int:item_id>/documentos")
def upload_document(item_id):
    bucket=os.getenv("S3_BUCKET")
    if not bucket: return jsonify(error="S3_BUCKET no está configurado"),503
    file=request.files.get("file")
    if not file or not file.filename: return jsonify(error="Adjunta un archivo en el campo file"),400
    from werkzeug.utils import secure_filename
    import boto3
    filename=secure_filename(file.filename)
    key=f"equipos/{item_id}/{filename}"
    s3=boto3.client("s3",region_name=os.getenv("AWS_REGION","us-east-1"))
    with db() as conn:
        if not conn.execute("SELECT id FROM equipment WHERE id=%s",(item_id,)).fetchone():
            return jsonify(error="Equipo no encontrado"),404
        s3.upload_fileobj(file,bucket,key)
        row=conn.execute("INSERT INTO documents(equipment_id,file_name,s3_key) VALUES(%s,%s,%s) RETURNING *",(item_id,filename,key)).fetchone()
    return jsonify(clean([row])[0]),201

@app.get("/equipos/<int:item_id>/documentos")
def documents(item_id):
    with db() as conn:
        rows=conn.execute("SELECT id,file_name,s3_key,created_at FROM documents WHERE equipment_id=%s ORDER BY id",(item_id,)).fetchall()
    return jsonify(clean(rows))
