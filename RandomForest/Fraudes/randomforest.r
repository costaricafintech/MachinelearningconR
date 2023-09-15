# Cargar las bibliotecas necesarias
library(randomForest)
library(caret)

# Cargar el conjunto de datos
datos <- read.csv("C://ProyectosR//conjunto_datos_fraude.csv")

# Seleccionar las columnas de interés
columnas_de_interes <- c("PaisResidencia", "PaisCompra", "TerminalID", "Fraude")
datos <- datos[, columnas_de_interes]

# Convertir la columna "Fraude" en factor
datos$Fraude <- as.factor(datos$Fraude)

# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(789)  # Puedes cambiar el seed si deseas
inTrain <- createDataPartition(datos$Fraude, p = 0.70, list = FALSE)
datos_entrenamiento <- datos[inTrain, ]
datos_prueba <- datos[-inTrain, ]

# Crear un modelo de Random Forest
modelo <- randomForest(Fraude ~ ., data = datos_entrenamiento, ntree = 100)

# Realizar predicciones en el conjunto de prueba
prediccion <- predict(modelo, newdata = datos_prueba, type = "response")

# Convertir las predicciones en factor (Si/No)
prediccion <- factor(prediccion, levels = c("Si", "No"))

# Crear una matriz de confusión
matriz_confusion <- confusionMatrix(prediccion, as.factor(datos_prueba$Fraude))

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
