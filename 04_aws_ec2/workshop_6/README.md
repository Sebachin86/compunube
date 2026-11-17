# Taller 6 — Una arquitectura que pueda crecer

La idea es no depender de una sola EC2. Un Application Load Balancer reparte las peticiones entre varias instancias y Auto Scaling agrega o quita máquinas según la carga. Poner instancias en más de una zona ayuda si una zona tiene problemas. Las APIs deberían ser stateless; los archivos se pueden guardar en S3 y los datos en una base administrada como RDS.

```mermaid
flowchart TB
 Internet --> ALB[Application Load Balancer]
 ALB --> ASG[Auto Scaling Group]
 ASG --> A[EC2 privada AZ-a]
 ASG --> B[EC2 privada AZ-b]
 A --> DB[(RDS PostgreSQL)]
 B --> DB
 A --> S3[(S3)]
 B --> S3
```
