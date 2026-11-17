# Reverse proxy y balanceador

Un reverse proxy recibe la petición y la manda al servicio que corresponda. Por ejemplo, puede enviar `/users` a una API y `/products` a otra. Un balanceador, en cambio, reparte las peticiones entre varias instancias del mismo servicio. Nginx puede hacer las dos cosas.
