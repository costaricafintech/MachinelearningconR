# Instala y carga las bibliotecas si aún no están instaladas
 install.packages("cluster")
 install.packages("ggplot2")
library(cluster)
library(ggplot2)

# Cargar el conjunto de datos de ejemplo
data(iris)
X <- iris[, 1:4]

# Calcular el WCSS para diferentes valores de k
wcss <- vector("double", length = 10)
for (i in 1:10) {
  kmeans_result <- kmeans(X, centers = i, nstart = 10)
  wcss[i] <- kmeans_result$tot.withinss
}

# Crear un gráfico del método del codo
k_values <- 1:10
elbow_plot <- data.frame(k = k_values, WCSS = wcss)
ggplot(elbow_plot, aes(x = k, y = WCSS)) +
  geom_line() +
  geom_point() +
  labs(title = "Método del Codo para Determinar el Número Óptimo de Clústeres", 
       x = "Número de Clústeres (k)", 
       y = "WCSS") +
  theme_minimal()
