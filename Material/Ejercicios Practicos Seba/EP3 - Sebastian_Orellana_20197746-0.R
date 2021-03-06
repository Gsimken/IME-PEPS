# Sebastian Orellana Verdejo
# 20.197.746-0

################################################################################
# Se importan las librer�as para graficar
library(ggplot2)
library(ggpubr)

##################################################################################
# Actividad: contraste de hip�tesis con una muestra
# Problema B
# El art�culo "Engineering Properties of Soil" (Soil Science 1998) puso a prueba la idea generalizada de que
# el 3% del suelo corresponde a materia org�nica. Para esto, los autores obtuvieron una muestra aleatoria
# de espec�menes de suelo, determinando que el porcentaje de materia org�nica presente en cada
# esp�cimen era (usando punto en vez de coma decimal):
# �Qu� conclusi�n sugerir�a a los autores?

# Se carga el Conjunto de datos a utilizar
texto <- "3.10 5.09 2.97 1.59 4.60 3.32 0.55 1.45 0.14 4.47
0.80 3.50 5.02 4.67 5.22 2.69 3.98 3.17 3.03 2.21
2.69 4.47 3.31 1.17 2.76 1.17 1.57 2.62 1.66 2.05"
file <- textConnection(texto)
datos <- scan(file)

# Se crea un historgrama de los datos para observar la distribuci�n
h1 <- gghistogram(datos, bins = 8, title = "Histograma % materia organica")
h1

# Hipotesis Nula: El 3% del suelo corresponde a materia org�nica

# Hipotesis Alternativa: El porcentaje de materia organica contenida
# en el suelo en diferente al 3%

# H0: u  = 3
# H1: u != 3

# Elegimos utlizar t de student dado que el tama�o de la muestra es
# de 30, sin embargo los datos no se parecen mucho a una 
# distribuci�n normal por lo que se decide utilizar un nivel de 
# significancia estricto
significancia <- 0.01 

prueba <- t.test(datos,
                 y=NULL,
                 alternative = c("two.sided"), 
                 mu=3,
                 conf.level = 1 - significancia)

# Se muestra el resultado de la prueba T
print(prueba)

# Conclusi�n:
# Como la media esta dentro del intervalo de confianza, y el p-valor
# es mayor que el nivel de significancia no se tiene la evidencia 
# suficiente para rechazar la hipotesis nula.


###############################################################################################################
# Actividad: contraste de hip�tesis con dos muestras

# Problema A
# Se sabe que la lactancia estimula una p�rdida de masa �sea para proporcionar cantidades de calcio
# adecuadas para la producci�n de leche. Un estudio intent� determinar si madres adolescentes pod�an
# recuperar niveles m�s normales a pesar de no consumir suplementos (Amer. J. Clinical Nutr., 2004; 1322-
# 1326). El estudio obtuvo las siguientes medidas del contenido total de minerales en los huesos del cuerpo
# (en gramos) para una muestra de madres adolescentes tanto durante la lactancia (6-24 semanas
# postparto) y posterior a ella (12-30 semana postparto):
# �Sugieren los datos que el contenido total de minerales en los huesos del cuerpo durante el posdestete
# excede el de la etapa de lactancia por m�s de 25 g? 

# Se carga los conjuntos de datos a utilizar
texto <- "1928 2549 2825 1924 1628 2175 2114 2621 1843 2541"
file <- textConnection(texto)
lactancia <- scan(file)

texto <- " 2126 2885 2895 1942 1750 2184 2164 2626 2006 2627"
file <- textConnection(texto)
postLactancia <- scan(file)

# Se crean los histogramas para observar la distribuci�n de los datos
h1 <- gghistogram(lactancia, bins = 5, title = "Histograma de lactancia")
h2 <- gghistogram(postLactancia, bins = 6, title = "Histograma de PostLactancia")
h3 <- gghistogram(postLactancia-lactancia, bins = 5, title = "Histograma diferencia de los datos")

# Se muestran los gr�ficos
h1
h2
h3

# Hipotesis Nula: La diferencia entre el contenido de minerales en el
# podestete y la lactancia es igual a 25

# Hipostesis Alternativa:  el contenido total de minerales en los 
# huesos delcuerpo durante el posdestete excede el de la etapa de
# lactancia por m�s de 25 g


# H0 -> media_post - media_lactancia = 25
# H1 -> media_post - media_lactancia > 25

# Para realizar el test se utliza una prueba T o de Student dado
# que el tama�o de la muestra es muy peque�o, sin embargo los datos
# no se parecen mucho a una distribuci�n normal por lo que se 
# decide utilizar un nivel de significancia mas estricto que 0.05

alfa <- 0.01

pruebaLactancia <- t.test(postLactancia, 
                          y = lactancia, 
                          mu = 25, 
                          paired = TRUE, 
                          alternative = "greater", 
                          conf.level = 1 - alfa)

# Se muestra el resultado de la prueba T
print(pruebaLactancia)

# Conclusi�n:
# No hay evidencia suficiente para rechazar H0, sin embargo dado que 
# el p-valor est� cerca del brode ser�a bueno obtener una muestra
# con m�s datos para estar completamente seguros

#################################################################################################################
# Problema B
# La avicultura de carne es un negocio muy lucrativo, y cualquier m�todo que ayude al r�pido crecimiento de
# los pollitos es beneficioso, tanto para las av�colas como para los consumidores. En el paquete datasets
# de R est�n los datos (chickwts) de un experimento hecho para medir la efectividad de varios
# suplementos alimenticios en la tasa de crecimiento de las aves. Pollitos reci�n nacidos se separaron
# aleatoriamente en 6 grupos, y a cada grupo se le dio un suplemento distinto. Para productores de la 7ma
# regi�n, es especialmente importante saber si existe diferencia en la efectividad entre el suplemento
# basado en linaza (linseed) y el basado en habas (horsebean).

# Se cargan el dataset a utilizar
datos <-as.data.frame(chickwts)
# Se dividen los datos seg�n los suplementos basados en linaza y los basados en habas
linaza <- datos$weight[datos$feed == "linseed"]
habas <- datos$weight[datos$feed == "horsebean"]

# Histogramas
h4 <- gghistogram(linaza, bins = 5, title = "Histograma de Linaza") 
h5 <- gghistogram(habas, bins = 5, title = "Histograma de Habas")

# Se muestran los gr�ficos
h4
h5

# Hipotesis Nula: No existe diferencia entre la efectividad del 
# suplemento basado en linaza y el basado en habas

# Hipotesis Alternativa: Si existe diferencia entre la efectividad 
# del suplemento basado en linaza y el basado en habas


# H0 -> media_linaza - media_habas = 0
# HA -> media_linaza - media_habas != 0

alfa <- 0.05

# Para realizar el test se utliza una prueba T o de Student dado
# que el tama�o de la muestra es muy peque�o
prueba2 <- t.test(x = linaza, 
                  y = habas, 
                  mu = 0, 
                  alternative = "two.sided", 
                  conf.level = 1 - alfa)

# Se muestra el resultado de la prueba T
print(prueba2)

# Conclusi�n:
# Dado que el p-valor es menor al alfa existe la evidencia suficiente 
# para rechazar la hipotesis nula por lo que s� existe una diferencia 
# de efectividad entre los suplementos.