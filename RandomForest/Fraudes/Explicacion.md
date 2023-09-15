## Documentación del Código para Análisis de Fraude con Random Forest

Este documento proporciona una explicación paso a paso del código R utilizado para analizar el fraude en transacciones utilizando el algoritmo Random Forest. El código utiliza la biblioteca `randomForest` y `caret` para entrenar el modelo y evaluar su rendimiento.

### Paso 1: Cargar Bibliotecas

```R
# Cargar las bibliotecas necesarias
library(randomForest)
library(caret)
```

En este paso, se cargan las bibliotecas `randomForest` y `caret`, que son esenciales para el modelado de Random Forest y la evaluación de modelos, respectivamente.

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

En este paso, se eligen las columnas relevantes del conjunto de datos, que incluyen "PaisResidencia," "PaisCompra," "TerminalID," y "Fraude."

### Paso 4: Convertir la Columna "Fraude" en Factor

```R
# Convertir la columna "Fraude" en factor
datos$Fraude <- as.factor(datos$Fraude)
```

Aquí, convertimos la columna "Fraude" en un factor para que el algoritmo pueda tratarla como una variable categórica.

### Paso 5: Dividir el Conjunto de Datos

```R
# Dividir el conjunto de datos en entrenamiento y prueba
set.seed(789)  # Puedes cambiar el seed si deseas
inTrain <- createDataPartition(datos$Fraude, p = 0.70, list = FALSE)
datos_entrenamiento <- datos[inTrain, ]
datos_prueba <- datos[-inTrain, ]
```

En este paso, dividimos el conjunto de datos en un conjunto de entrenamiento (70%) y un conjunto de prueba (30%) utilizando `createDataPartition` de `caret`. El valor `set.seed` se utiliza para asegurar la reproducibilidad de los resultados.

### Paso 6: Crear un Modelo de Random Forest

```R
# Crear un modelo de Random Forest
modelo <- randomForest(Fraude ~ ., data = datos_entrenamiento, ntree = 100)
```

Aquí, creamos un modelo de Random Forest utilizando la función `randomForest`. El modelo intenta predecir la variable "Fraude" en función de las otras variables predictoras. `ntree` se establece en 100, lo que indica el número de árboles en el bosque.

### Paso 7: Realizar Predicciones

```R
# Realizar predicciones en el conjunto de prueba
prediccion <- predict(modelo, newdata = datos_prueba, type = "response")
```

En este paso, hacemos predicciones en el conjunto de prueba utilizando el modelo creado. `type = "response"` se utiliza para obtener las probabilidades de las clases.

### Paso 8: Convertir las Predicciones en Factor (Si/No)

```R
# Convertir las predicciones en factor (Si/No)
prediccion <- factor(prediccion, levels = c("Si", "No"))
```

Aseguramos que las categorías en las predicciones sean consistentes utilizando la función `factor` y definiendo los niveles explícitamente como "Si" y "No."

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

Este código completo permite cargar un conjunto de datos, entrenar un modelo de Random Forest, realizar predicciones y evaluar el rendimiento del modelo en la detección de fraude en transacciones.