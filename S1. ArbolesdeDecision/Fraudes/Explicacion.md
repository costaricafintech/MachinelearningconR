## Documentación del Código para Análisis de Fraude

Este documento proporciona una explicación paso a paso del código R utilizado para analizar el fraude en transacciones. El código utiliza un modelo de Árbol de Decisión y evalúa su rendimiento utilizando métricas de evaluación y una matriz de confusión.

### Paso 1: Cargar Bibliotecas

```R
# Cargar las bibliotecas necesarias
library(rpart)
library(caret)
```

En este paso, cargamos las bibliotecas `rpart` y `caret`, que son esenciales para el modelado de Árboles de Decisión y la evaluación de modelos, respectivamente.

### Paso 2: Cargar el Conjunto de Datos

```R
# Cargar el conjunto de datos
datos <- read.csv("C://ProyectosR//conjunto_datos_fraude.csv")
```

Este paso implica cargar el conjunto de datos desde un archivo CSV ubicado en "C://ProyectosR//conjunto_datos_fraude.csv" en la variable `datos`.

### Paso 3: Seleccionar Columnas de Interés

```R
# Seleccionar las columnas de interés
columnas_de_interes <- c("PaisResidencia", "PaisCompra", "TerminalID", "Fraude")
datos <- datos[, columnas_de_interes]
```

Aquí, se eligen las columnas relevantes del conjunto de datos, que incluyen "PaisResidencia," "PaisCompra," "TerminalID," y "Fraude."

### Paso 4: Dividir el Conjunto de Datos

```R
# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(789)  # Puedes cambiar el seed si deseas
inTrain <- createDataPartition(datos$Fraude, p = 0.70, list = FALSE)
datos_entrenamiento <- datos[inTrain, ]
datos_prueba <- datos[-inTrain, ]
```

En este paso, dividimos el conjunto de datos en un conjunto de entrenamiento (70%) y un conjunto de prueba (30%) utilizando `createDataPartition` de `caret`. El valor `set.seed` se utiliza para asegurar la reproducibilidad de los resultados.

### Paso 5: Crear un Modelo de Árbol de Decisión

```R
# Crear un modelo de Árbol de Decisión
modelo <- rpart(Fraude ~ ., data = datos_entrenamiento, method = "class")
```

Aquí, creamos un modelo de Árbol de Decisión utilizando la función `rpart`. El modelo intenta predecir la variable "Fraude" en función de las otras variables predictoras.

### Paso 6: Realizar Predicciones

```R
# Realizar predicciones en el conjunto de prueba
prediccion_prob <- predict(modelo, newdata = datos_prueba, type = "prob")
```

En este paso, hacemos predicciones en el conjunto de prueba utilizando el modelo creado y obtenemos las probabilidades para la clase positiva (fraude).

### Paso 7: Asignar Clases

```R
# Asignar clases en función de un umbral personalizado (por ejemplo, 0.7)
umbral <- 0.7
prediccion <- ifelse(prob_positiva >= umbral, "Si", "No")
```

Aquí, asignamos clases ("Si" o "No") en función de un umbral personalizado. En este caso, si la probabilidad de fraude es mayor o igual a 0.7, se clasifica como "Si"; de lo contrario, se clasifica como "No."

### Paso 8: Asegurar la Consistencia de las Categorías

```R
# Asegurarse de que las categorías sean consistentes
prediccion <- factor(prediccion, levels = c("Si", "No"))
```

Aseguramos que las categorías en las predicciones sean consistentes utilizando la función `factor` y definiendo los niveles explícitamente.

### Paso 9: Crear una Matriz de Confusión y Métricas de Evaluación

```R
# Crear una matriz de confusión
matriz_confusion <- confusionMatrix(prediccion, as.factor(datos_prueba$Fraude))
```

En este paso, creamos una matriz de confusión utilizando la función `confusionMatrix` de `caret`. La matriz de confusión muestra el rendimiento del modelo en términos de precisión, sensibilidad y especificidad.

### Paso 10: Imprimir Métricas de Evaluación

```R
# Obtener métricas adicionales
precision <- matriz_confusion$overall["Accuracy"]
sensibilidad <- matriz_confusion$byClass["Sensitivity"]
especificidad <- matriz_confusion$byClass["Specificity"]

# Imprimir métricas adicionales
cat("Precisión:", precision, "\n")
cat("Sensibilidad:", sensibilidad, "\n")
cat("Especificidad:", especificidad, "\n")
```

Finalmente, calculamos y mostramos las métricas adicionales de evaluación, que incluyen la precisión, sensibilidad y especificidad del modelo.

Este código completo permite cargar un conjunto de datos, entrenar un modelo de Árbol de Decisión, realizar predicciones y evaluar el rendimiento del modelo en la detección de fraude en transacciones.