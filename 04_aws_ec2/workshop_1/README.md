# Taller 1 — Crear y conectarse a una EC2

En la consola de AWS selecciono una región y una imagen Ubuntu LTS. Creo un par de claves y guardo el `.pem` fuera del repositorio. En el Security Group dejo SSH por el puerto 22 solo desde mi IP (`TU_IP/32`). Para conectarme uso `chmod 400 clave.pem` y luego `ssh -i clave.pem ubuntu@IP_PUBLICA`.

La AMI es la plantilla del sistema; el tipo de instancia define recursos como CPU y RAM; el Security Group funciona como firewall; y la VPC/subred define en qué red queda la máquina.
