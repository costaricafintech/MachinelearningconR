# Cargar el conjunto de datos iris
data(iris)

# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(123)  # Para reproducibilidad
indices <- sample(1:nrow(iris), nrow(iris) * 0.7)  # 70% para entrenamiento
train_data <- iris[indices, ]
test_data <- iris[-indices, ]

# Cargar la biblioteca "class" para usar k-NN
library(class)

# Definir el número de vecinos (k)
k <- 3

# Realizar la clasificación k-NN
predicted_species <- knn(train_data[, 1:4], test_data[, 1:4], train_data[, 5], k)

# Evaluar la precisión de la clasificación
accuracy <- sum(predicted_species == test_data[, 5]) / nrow(test_data)
cat("Precisión del modelo k-NN:", accuracy)