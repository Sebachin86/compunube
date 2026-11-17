# Subir la imagen a ECR y desplegar en EC2

Dejé estos pasos para cuando vaya a hacer el despliegue real. Primero reviso que AWS CLI esté configurado y que la identidad sea la correcta:

```bash
aws sts get-caller-identity
```

Después creo el repositorio ECR, inicio sesión desde Docker, construyo la imagen y la publico. El script `scripts/build-and-push-ecr.sh` ayuda con esa parte. En EC2 uso un rol IAM para descargar la imagen y acceder solo al bucket S3 que necesite; no copio claves de AWS al servidor.

En el Security Group dejo públicos solo los puertos que vaya a usar Nginx (80/443). No publico directamente Flask (5000) ni PostgreSQL (5432). Al terminar, reviso Billing y elimino los recursos que ya no necesite.
