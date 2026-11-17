# Taller 5 — User Data

Al crear la EC2, pego `user-data-nginx.sh` en **Advanced details → User data**. Si voy a mostrar la página, dejo permitido el puerto 80. Después reviso con `cloud-init status --long`, `systemctl status nginx` y `curl http://localhost`. User Data sirve para que la instancia haga la configuración inicial automáticamente.
