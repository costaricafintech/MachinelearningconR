# Cargar las bibliotecas necesarias
library(rpart)
library(caret)

# Cargar el conjunto de datos
datos <- read.csv("C://ProyectosR//conjunto_datos_fraude.csv")


# Seleccionar las columnas de interés
columnas_de_interes <- c("PaisResidencia", "PaisCompra", "TerminalID", "Fraude")
datos <- datos[, columnas_de_interes]

# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(789)  # Puedes cambiar el seed si deseas
inTrain <- createDataPartition(datos$Fraude, p = 0.70, list = FALSE)
datos_entrenamiento <- datos[inTrain, ]
datos_prueba <- datos[-inTrain, ]

# print(head(datos_entrenamiento))
# print(head(datos_prueba))

# Crear un modelo de Árbol de Decisión
 modelo <- rpart(Fraude ~ ., data = datos_entrenamiento, method = "class")

# Realizar predicciones en el conjunto de prueba
 prediccion_prob <- predict(modelo, newdata = datos_prueba, type = "prob")

# Obtener las probabilidades para la clase positiva (fraude)
 prob_positiva <- prediccion_prob[, "Si"]

# Asignar clases en función de un umbral personalizado (por ejemplo, 0.5)
 umbral <- 0.7
 prediccion <- ifelse(prob_positiva >= umbral, "Si", "No")

# Asegurarse de que las categorías sean consistentes
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