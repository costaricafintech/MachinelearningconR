# Cargar las bibliotecas necesarias
library(caret)
library(rpart)

# Cargar el conjunto de datos
conjunto_datos <- read.csv("C://ProyectosR//conjunto_datos_fraude.csv")

# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(123)
inTrain <- createDataPartition(conjunto_datos$fraude, p = 0.70, list = FALSE)
datos_entrenamiento <- conjunto_datos[inTrain, ]
datos_prueba <- conjunto_datos[-inTrain, ]

# Crear un modelo de Árbol de Decisión
modelo <- rpart(fraude ~ ., data = datos_entrenamiento)

# Realizar predicciones en el conjunto de prueba
prediccion <- predict(modelo, newdata = datos_prueba)

# Obtener las probabilidades para la clase positiva (fraude)
prob_positiva <- ifelse(prediccion == "1", 1, 0)

# Asegurarse de que las categorías sean consistentes
categorias_deseadas <- levels(datos_prueba$fraude)
prob_positiva <- factor(prob_positiva, levels = categorias_deseadas)

# Crear una matriz de confusión
matriz_confusion <- confusionMatrix(prob_positiva, datos_prueba$fraude)

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

