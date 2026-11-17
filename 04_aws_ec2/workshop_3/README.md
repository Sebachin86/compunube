# Taller 3 — Docker en EC2

Instalo Docker según la distribución que tenga la instancia y levanto el montaje con `docker compose up --build -d`. En el Security Group abro el puerto 80 para probar la página desde el navegador. Flask queda por dentro en el puerto 5000 y Nginx es el que recibe las visitas. Para bajar los contenedores uso `docker compose down`.
