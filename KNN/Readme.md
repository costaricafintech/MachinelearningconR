k-Nearest Neighbors (k-NN):

El algoritmo k-NN es un método de aprendizaje supervisado utilizado tanto para problemas de clasificación como para regresión. Su principio fundamental es que los objetos similares tienden a estar cerca en el espacio de características. En otras palabras, asume que si un objeto se parece a sus vecinos más cercanos, entonces debe clasificarse o predecirse de manera similar a ellos.

El "k" en k-NN representa el número de vecinos más cercanos que se utilizarán para tomar una decisión sobre la clasificación o la predicción. Para realizar una clasificación o predicción, el algoritmo sigue estos pasos:

Calcula la distancia entre el nuevo punto (el que queremos clasificar o predecir) y todos los puntos de datos en el conjunto de entrenamiento. La distancia más comúnmente utilizada es la distancia euclidiana, pero también pueden utilizarse otras métricas de distancia.

Selecciona los "k" puntos más cercanos al nuevo punto según la distancia calculada.

En el caso de clasificación, cuenta las etiquetas de clase de los "k" puntos más cercanos y asigna la etiqueta de clase más frecuente como la predicción para el nuevo punto.

En el caso de regresión, calcula el valor promedio (o una ponderación basada en la distancia) de los "k" puntos más cercanos y lo asigna como la predicción para el nuevo punto.

Ejemplo de k-NN en R:

Vamos a utilizar un ejemplo sencillo de clasificación con k-NN en R utilizando el conjunto de datos "iris", que es un conjunto de datos de flores con tres clases diferentes.

```R
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
```

En este ejemplo, dividimos el conjunto de datos "iris" en conjuntos de entrenamiento y prueba, luego utilizamos la función knn del paquete "class" para realizar la clasificación k-NN. Luego, calculamos la precisión del modelo comparando las predicciones con las etiquetas reales en el conjunto de prueba.