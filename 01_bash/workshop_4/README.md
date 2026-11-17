# Taller 4 — Funciones, procesos y logs JSON

Se generan eventos en formato JSONL y después se filtran los errores y los códigos HTTP 500. También se revisan procesos. Hace falta tener `jq` instalado (`sudo apt install jq`). El script no mata procesos por su cuenta; antes de cerrar alguno, reviso bien el PID.
