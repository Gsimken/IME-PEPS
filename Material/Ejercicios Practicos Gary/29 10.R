#Problema A
#Se sabe que la lactancia estimula una pérdida de masa ósea para proporcionar cantidades de calcio
#adecuadas para la producción de leche. Un estudio intentó determinar si madres adolescentes podían
#recuperar niveles más normales a pesar de no consumir suplementos (Amer. J. Clinical Nutr., 2004; 1322-
#1326). El estudio obtuvo las siguientes medidas del contenido total de minerales en los huesos del cuerpo
#(en gramos) para una muestra de madres adolescentes tanto durante la lactancia (6-24 semanas
#postparto) y posterior a ella (12-30 semana postparto):

#Sujeto     1     2     3     4     5     6     7     8     9     10
#Lactancia  1928  2549  2825  1924  1628  2175  2114  2621  1843  2541
#Posdestete 2126  2885  2895  1942  1750  2184  2164  2626  2006  2627

#¿Sugieren los datos que el contenido total de minerales en los huesos del cuerpo durante el posdestete
#excede el de la etapa de lactancia por más de 25 g? 


#H0: Xposdestete - Xlactancia = 25
#HA: Xposdestete - Xlactancia > 25

Lactancia<- c(1928 ,2549, 2825, 1924, 1628, 2175, 2114, 2621, 1843, 2541)
Posdestete<-c(2126, 2885, 2895, 1942, 1750, 2184, 2164, 2626, 2006, 2627)
x<-Posdestete-Lactancia
#analisis de datos
ggqqplot(Lactancia,color="blue",fill="red")
ggqqplot(Posdestete,color="red",fill="blue")
gghistogram(x,bins = 7)
#Analizando los datos, no podemos ver ningun valor atipico, sin embaro al restar ambas muestras obtenemos una asimetría.
#dado esto usaremos un alfa mas estricto
alfa <- 0.01


pruebat <- t.test(Posdestete,Lactancia, alternative = "greater", paired=TRUE , conf.level=1-alfa,mu=25)
pruebat

#p-value > alfa, se rechaza la hipotesis nula
#no hay evidencia suficiente para rechazar que el contenido total de minerales en los huesos del cuerpo durante el posdestete
#sea igual a 25 en la etapa de lactancia



#######################################################################################
#Problema B
#La avicultura de carne es un negocio muy lucrativo, y cualquier método que ayude al rápido crecimiento de
#los pollitos es beneficioso, tanto para las avícolas como para los consumidores. En el paquete datasets
#de R están los datos (chickwts) de un experimento hecho para medir la efectividad de varios
#suplementos alimenticios en la tasa de crecimiento de las aves. Pollitos recién nacidos se separaron
#aleatoriamente en 6 grupos, y a cada grupo se le dio un suplemento distinto. Para productores de la 7ma
#región, es especialmente importante saber si existe diferencia en la efectividad entre el suplemento
#basado en linaza (linseed) y el basado en habas (horsebean).

#h0: linaza-haba = 0
#h1: linaza-haba != 0
datos <- chickwts
habas <- datos[0:10,1]
linaza <- datos[11:22,1]
#analisis de datos
ggqqplot(habas,color="blue",fill="red")
ggqqplot(linaza,color="red",fill="blue")
#existe al menos un valor atipíco, por lo que se usara un alpha un poco mas estrico que el estandar(0.05)
alfa=0.03


pruebat <- t.test(linaza ,habas, alternative = "two.sided", conf.level=1-alfa,mu=0)
pruebat
#p-value < alfa se rechaza H0
#significando esto que existe una diferencia entre usar linaza o habas en crecimiento de pollos.