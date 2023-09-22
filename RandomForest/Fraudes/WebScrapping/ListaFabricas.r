# Cargar las bibliotecas necesarias
library(rvest)
library(readr)

# URL de la página web que deseas descargar
url <- "https://agg.org.gt/directorio/industria/industria-manufacturera/"

# Realizar la solicitud a la página web y extraer el contenido
pagina <- read_html(url)

# Supongamos que deseas extraer una tabla específica de la página web.
# Reemplaza "selector_de_tabla" con el selector CSS adecuado para tu caso.
tabla <- pagina %>%
  html_node(selector_de_tabla) %>%
  html_table()

# Guardar la tabla en un archivo CSV
if (!is.null(tabla)) {
  write_csv(tabla, "C://ProyectosR/datos.csv")
  cat("Los datos se han guardado en datos.csv\n")
} else {
  cat("No se pudo encontrar la tabla en la página web.\n")
}
