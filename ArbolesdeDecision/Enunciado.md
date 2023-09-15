# Enunciado

El objetivo de este trabajo universitario es utilizar el método de Árboles de Clasificación para resolver un problema de Machine Learning. Finalmente, se realizará un análisis de los resultados y se presentará un informe sobre los hallazgos obtenidos en el estudio.

Un caso de uso común para el algoritmo de árbol de decisión es la clasificación de productos en un catálogo de ventas como vendidos o no vendidos en función de una serie de variables predictoras.

Por ejemplo, supongamos que se tiene un conjunto de datos que contienen información sobre productos en un catálogo de ventas, incluyendo variables como el precio, el tamaño, el color, la marca y la categoría.

Usted debe utilizar un modelo de árbol de decisión para clasificar los productos como vendidos o no vendidos en función de estas variables. Debe tomar los datos que se encuentran en el archivo “datos_catalogo.csv” como fuente para este caso.

Adicionalmente debe tomar en cuenta los siguientes supuestos:

- Las predicciones en el conjunto de prueba deben realizarse utilizando la función predict.
- Debe crear una matriz de confusión utilizando la función confusionMatrix de la biblioteca caret, lo que permite evaluar el rendimiento del modelo en la clasificación binaria.
- La matriz de confusión debe mostrar la precisión, sensibilidad, especificidad y otras métricas de evaluación del modelo.