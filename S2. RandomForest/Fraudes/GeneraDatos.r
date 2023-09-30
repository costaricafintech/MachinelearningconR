# Cargar bibliotecas necesarias
library(dplyr)

# Establecer la semilla aleatoria para reproducibilidad
set.seed(1456)

# Función para generar fechas aleatorias dentro de un rango
generate_random_dates <- function(n) {
  start_date <- as.POSIXct("2020-01-01")
  end_date <- as.POSIXct("2023-01-01")
  random_dates <- as.POSIXct(runif(n, start_date, end_date), origin = "1970-01-01")
  return(random_dates)
}

# Generar un conjunto de datos ficticio para predicción de fraude
n <- 10000000  # Número de observaciones

# Ajustar las probabilidades de fraude para equilibrar las clases
proporcion_transacciones_en_linea <- 1 / 2
proporcion_transacciones_en_tienda <- 1 / 2

datos <- data.frame(
  Edad = sample(18:65, n, replace = TRUE),
  Genero = sample(c("Masculino", "Femenino"), n, replace = TRUE),
  PaisResidencia = sample(c("EE. UU.", "Canada", "Reino Unido", "Costa Rica", "Otros"), n, replace = TRUE),
  FechaHora = generate_random_dates(n),
  TerminalID = sample(1:1000, n, replace = TRUE),
  FrecuenciaCompras = sample(1:10, n, replace = TRUE),
  MontoPromedioCompra = runif(n, min = 10, max = 1000),
  TipoTransaccion = sample(c("En linea", "Tienda fisica"), n, replace = TRUE),
  PaisCompra = sample(c("EE. UU.", "China", "Mexico", "Costa Rica"), n, prob = c(0.75, 0.10, 0.05, 0.10), replace = TRUE),
  CategoriaNegocio = sample(c("Hotel", "Restaurante", "Supermercado", "Farmacia", "Salud", "Aerolinea"), n, replace = TRUE)
)

# Agregar una columna de etiquetas de fraude (ficticias)
transacciones_fraudulentas <- rep(0, n)
transacciones_en_linea <- datos$TipoTransaccion == "En linea"
transacciones_tienda <- datos$TipoTransaccion == "Tienda fisica"

transacciones_fraudulentas[transacciones_en_linea] <- rbinom(sum(transacciones_en_linea), 1, proporcion_transacciones_en_linea)
transacciones_fraudulentas[transacciones_tienda] <- rbinom(sum(transacciones_tienda), 1, proporcion_transacciones_en_tienda)

datos$Fraude <- ifelse(transacciones_fraudulentas == 1, "Si", "No")

write.csv(datos, "C://ProyectosR//conjunto_datos_fraude.csv", row.names = FALSE)