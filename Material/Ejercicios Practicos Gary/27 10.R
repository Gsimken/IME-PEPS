library(TeachingDemos)
library(datasets)
library(ggplot2)
library(ggpubr)
#Ejerciio Clase 27/10

#Problema A
#El art?culo "Automatic Segmentation of Medical Images Using Image Registration: Diagnostic and
#Simulation Applications" (Journal of Medical Engeeniering and Technology 2005) propuso una nueva
#t?cnica para la identificaci?n autom?tica de los bordes de estructuras significativas en una imagen m?dica
#utilizando desplazamiento lineal promedio (ALD, por sus siglas en ingl?s). El art?culo dio las siguientes
#observaciones de ALD con una muestra de 49 ri?ones (en pixeles y usando punto en vez de coma
#decimal).
#1.38 0.98 1.09 0.77 0.66 1.28 0.61 1.49 0.81 0.36 0.84 0.83 0.61 0.64
#1.30 0.57 0.43 0.62 1.00 1.05 0.82 1.10 0.65 0.99 0.56 0.66 0.64 1.45
#0.82 1.06 0.41 0.58 0.66 1.14 0.73 0.59 0.51 1.04 0.85 0.45 0.82 1.01
#1.11 0.34 1.25 0.38 1.44 1.28 0.91
#Los autores comentaron que el ALD medio estar?a alrededor de 1.0. ?Los datos soportan esta afirmaci?n?

# Hipotesis
# H0: mu = 1
# H1: mu != 1


# Condiciones
sample <- c(1.38,0.98,1.09,0.77,0.66,1.28,0.61,1.49,0.81,0.36,0.84,0.83,0.61,0.64,1.30,0.57,0.43,0.62,1.00,1.05,0.82,1.10,0.65,0.99,0.56,0.66,0.64,1.45,0.82,1.06,0.41,0.58,0.66,1.14,0.73,0.59,0.51,1.04,0.85,0.45,0.82,1.01,1.11,0.34,1.25,0.38,1.44,1.28,0.91)

#Se analiza si hay alguna muestra atipica
ggqqplot(sample,color="blue",fill="red")
#No se nota ninguna por lo que se usara un alfa estandar
alfa <- 0.05


desviacion <- sd(sample)
media <- mean(sample)
z <- z.test(x = sample, alternative = "two.sided", mu = 1, sd = desviacion, conf.level =  1-alfa)
z
#Dado que p<alfa se rechaza H0
#por lo que como H0 no es ni sercana a alfa, se puede concluir que los datos no soportaron la afirmacion


##################################################################

#Ejercicios clase 29/10

#Problema A
#Se sabe que la lactancia estimula una p?rdida de masa ?sea para proporcionar cantidades de calcio
#adecuadas para la producci?n de leche. Un estudio intent? determinar si madres adolescentes pod?an
#recuperar niveles m?s normales a pesar de no consumir suplementos (Amer. J. Clinical Nutr., 2004; 1322-
#1326). El estudio obtuvo las siguientes medidas del contenido total de minerales en los huesos del cuerpo
#(en gramos) para una muestra de madres adolescentes tanto durante la lactancia (6-24 semanas
#postparto) y posterior a ella (12-30 semana postparto):

#Sujeto     1     2     3     4     5     6     7     8     9     10
#Lactancia  1928  2549  2825  1924  1628  2175  2114  2621  1843  2541
#Posdestete 2126  2885  2895  1942  1750  2184  2164  2626  2006  2627

#?Sugieren los datos que el contenido total de minerales en los huesos del cuerpo durante el posdestete
#excede el de la etapa de lactancia por m?s de 25 g? 


#H0: Xposdestete - Xlactancia = 25
#HA: Xposdestete - Xlactancia > 25

Lactancia<- c(1928 ,2549, 2825, 1924, 1628, 2175, 2114, 2621, 1843, 2541)
Posdestete<-c(2126, 2885, 2895, 1942, 1750, 2184, 2164, 2626, 2006, 2627)
x<-Posdestete-Lactancia
#analisis de datos
ggqqplot(Lactancia,color="blue",fill="red")
ggqqplot(Posdestete,color="red",fill="blue")
gghistogram(x,bins = 7)
#Analizando los datos, no podemos ver ningun valor atipico, sin embaro al restar ambas muestras obtenemos una asimetr?a.
#dado esto usaremos un alfa mas estricto
alfa <- 0.01


pruebat <- t.test(Posdestete,Lactancia, alternative = "greater", paired=TRUE , conf.level=1-alfa,mu=25)
pruebat

#p-value > alfa, se rechaza la hipotesis nula
#no hay evidencia suficiente para rechazar que el contenido total de minerales en los huesos del cuerpo durante el posdestete
#sea igual a 25 en la etapa de lactancia



#######################################################################################

#Problema B
#La avicultura de carne es un negocio muy lucrativo, y cualquier m?todo que ayude al r?pido crecimiento de
#los pollitos es beneficioso, tanto para las av?colas como para los consumidores. En el paquete datasets
#de R est?n los datos (chickwts) de un experimento hecho para medir la efectividad de varios
#suplementos alimenticios en la tasa de crecimiento de las aves. Pollitos reci?n nacidos se separaron
#aleatoriamente en 6 grupos, y a cada grupo se le dio un suplemento distinto. Para productores de la 7ma
#regi?n, es especialmente importante saber si existe diferencia en la efectividad entre el suplemento
#basado en linaza (linseed) y el basado en habas (horsebean).

#h0: linaza-haba = 0
#h1: linaza-haba != 0
datos <- chickwts
habas <- datos[0:10,1]
linaza <- datos[11:22,1]
#analisis de datos
ggqqplot(habas,color="blue",fill="red")
ggqqplot(linaza,color="red",fill="blue")
#existe al menos un valor atip?co, por lo que se usara un alpha un poco mas estrico que el estandar(0.05)
alfa=0.03


pruebat <- t.test(linaza ,habas, alternative = "two.sided", conf.level=1-alfa,mu=0)
pruebat
#p-value < alfa se rechaza H0
#significando esto que existe una diferencia entre usar linaza o habas en crecimiento de pollos.
