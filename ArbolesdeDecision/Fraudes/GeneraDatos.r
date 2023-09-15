# Cargar la biblioteca "data.table" para manejar grandes conjuntos de datos
library(data.table)

# Establecer una semilla para la reproducibilidad
set.seed(123)

# Crear un conjunto de datos grande (10,000,000 de registros) con clases balanceadas # nolint
n <- 10000000
n_fraude <- n / 2
n_no_fraude <- n / 2

# Generar datos de fraude
fraude <- data.table(
  id = 1:n_fraude,
  monto = runif(n_fraude, 1, 1000),
  ubicacion = sample(c("EEUU", "Europa", "Asia"), n_fraude, replace = TRUE),
  tipo_tarjeta = sample(c("Visa", "MasterCard", "Amex"), n_fraude, replace = TRUE), # nolint
  fraude = 1  # Etiqueta para transacciones fraudulentas
)

# Generar datos de no fraude
no_fraude <- data.table(
  id = (n_fraude + 1):(n_fraude + n_no_fraude),
  monto = runif(n_no_fraude, 1, 1000),
  ubicacion = sample(c("EEUU", "Europa", "Asia"), n_no_fraude, replace = TRUE),
  tipo_tarjeta = sample(c("Visa", "MasterCard", "Amex"), n_no_fraude, replace = TRUE), # nolint
  fraude = 0  # Etiqueta para transacciones legítimas (no fraudulentas)
)

# Combinar los datos de fraude y no fraude en un solo conjunto de datos
conjunto_datos <- rbind(fraude, no_fraude)

# Guardar el conjunto de datos en un archivo CSV
write.csv(conjunto_datos, "C://ProyectosR//conjunto_datos_fraude.csv", row.names = FALSE) # nolint
