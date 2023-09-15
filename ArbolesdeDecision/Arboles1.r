# Cargar las bibliotecas necesarias
library(caret)
library(rpart)

# Cargar el conjunto de datos
datos <- read.csv("C://ProyectosR//datos_catalogo.csv")

# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(123)
inTrain <- createDataPartition(datos$vendido, p = 0.70, list = FALSE)
datos_entrenamiento <- datos[inTrain, ]
datos_prueba <- datos[-inTrain, ]

# Crear un modelo de árbol de decisión
modelo <- rpart(vendido ~ ., data = datos_entrenamiento)

# Realizar predicciones en el conjunto de prueba
prediccion <- predict(modelo, newdata = datos_prueba)

# Asegurarse de que la variable objetivo sea un factor
datos_prueba$vendido <- as.factor(datos_prueba$vendido)

# Extraer la columna de predicción del modelo
prediccion_binaria <- as.factor(ifelse(prediccion[, "Si"] >= 0.5, "Si", "No"))

# Asegurarse de que ambos vectores tengan la misma longitud
if (length(prediccion_binaria) != length(datos_prueba$vendido)) {
  stop("Las longitudes de las predicciones y las etiquetas reales no coinciden.")
}

# Crear una matriz de confusión
matriz_confusion <- confusionMatrix(prediccion_binaria, datos_prueba$vendido)

# Imprimir la matriz de confusión
print(matriz_confusion)

# Obtener métricas adicionales
precision <- matriz_confusion$overall["Accuracy"]
sensibilidad <- matriz_confusion$byClass["Sensitivity"]
especificidad <- matriz_confusion$byClass["Specificity"]

# Imprimir métricas adicionales
cat("Precisión:", precision, "\n")
cat("Sensibilidad:", sensibilidad, "\n")
cat("Especificidad:", especificidad, "\n")
