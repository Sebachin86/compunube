# Preguntas del taller

Si solo tengo una EC2 y se cae, el servicio queda fuera. Si llega mucho tráfico, esa máquina puede quedarse corta. Con un ALB puedo repartir las peticiones y con Auto Scaling agregar instancias cuando haga falta. Si guardo sesiones o archivos solo dentro de una EC2, las otras no los van a ver; por eso conviene usar tokens o almacenamiento compartido como S3/EFS. La base de datos también necesita su propio plan de escalabilidad.
