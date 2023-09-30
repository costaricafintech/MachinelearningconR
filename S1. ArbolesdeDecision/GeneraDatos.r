library(MASS)

# Generar un conjunto de datos de 1000 productos
set.seed(1)
datos_catalogo <- data.frame(
  precio = rnorm(1000000, 10, 5),
  tamano = sample(c("pequeno", "mediano", "grande"), 1000000, replace = T),
  color = sample(c("rojo", "azul", "verde", "negro", "blanco"), 1000000, replace = T),
  marca = sample(c("Apple", "Samsung", "LG", "Sony", "Asus"), 1000000, replace = T),
  categoria = sample(c("smartphone", "tablet", "computadora", "televisor", "accesorios"), 1000000, replace = T),
  vendido = sample(c("Si", "No"), 1000000, replace = T)
)

# Guardar el conjunto de datos en un archivo
write.csv(datos_catalogo, "C://ProyectosR//datos_catalogo.csv")
