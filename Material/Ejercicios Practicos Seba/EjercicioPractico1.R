#Integrantes
#Sebastian Orellana 20197746-0
#Gary Simken 19986690-7
#Instalacion paquete
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

#Carga de datos
datos = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data")
datos = datos[, c(1, 5, 6, 7, 8)]
names(datos) = c('sexo', 'total', 'carne', 'visceras', 'concha')

#Crear semilla
set.seed(20197746)

#Libreria
library(ggpubr)

#Se obtiene la muestra de 300 datos
datosSample = datos[sample(1:nrow(datos),size=300,replace=FALSE),]

#Se crea grafico Peso de la concha vs peso de la carne
ggscatter(datosSample,'carne','concha',title='Concha vs Carne',xlab='Peso de la carne',ylab='Peso de la concha')

#Se crea grafico Peso de la concha vs peso total de los abulones
ggscatter(datosSample,'total','concha',title='Concha vs Total Abulones',xlab='Peso de los abulones',ylab='Peso de la concha')

#Histograma
#Es posible realizar el histograma, pero por cuestiones de tiempo no se logro

#Media Muestral
mediaTotalM=mean(datosSample$total)
mediaCarneM=mean(datosSample$carne)
mediaViscerasM=mean(datosSample$visceras)
mediaConchaM=mean(datosSample$concha)

#Mediana Muestra
medianaTotalM=median(datosSample$total)
medianaCarneM=median(datosSample$carne)
medianaViscerasM=median(datosSample$visceras)
medianaConchaM=median(datosSample$concha)

#Varianza Muestral
varTotalM=var(datosSample$total)
varCarneM=var(datosSample$carne)
varViscerasM=var(datosSample$visceras)
varConchaM=var(datosSample$concha)


#Desviacion estandar Muestral
DETotalM=sd(datosSample$total)
DECarneM=sd(datosSample$carne)
DEViscerasM=sd(datosSample$visceras)
DEConchaM=sd(datosSample$concha)

#Media Poblacional
mediaTotalP=mean(datos$total)
mediaCarneP=mean(datos$carne)
mediaViscerasP=mean(datos$visceras)
mediaConchaP=mean(datos$concha)

#Mediana Poblacional
medianaTotalP=median(datos$total)
medianaCarneP=median(datos$carne)
medianaViscerasP=median(datos$visceras)
medianaConchaP=median(datos$concha)


#Varianza Poblacional
varTotalP=var(datos$total)
varCarneP=var(datos$carne)
varViscerasP=var(datos$visceras)
varConchaP=var(datos$concha)


#Desviacion estandar Poblacional
DETotalP=sd(datos$total)
DECarneP=sd(datos$carne)
DEViscerasP=sd(datos$visceras)
DEConchaP=sd(datos$concha)

#Se Genera tabla comparativa
estadisticos<- data.frame(
  "Variables"=c("Total","Carne","Visceras","Concha"),  
  "Media Muestral"=c(mediaTotalM,mediaCarneM,mediaViscerasM,mediaConchaM),
  "Media Poblacional" = c(mediaTotalP,mediaCarneP,mediaViscerasP,mediaConchaP),
  "Mediana Muestral"=c(medianaTotalM,medianaCarneM,medianaViscerasM,medianaConchaM),
  "Media Poblacional"=c(medianaTotalP,medianaCarneP,medianaViscerasP,medianaConchaP),
  "Var Muestral"= c(varTotalM,varCarneM,varViscerasM,varConchaM),
  "Var Poblacional"=c(varTotalP,varCarneP,varViscerasP,varConchaP),
  "D.Estandar Muestral"=c(DETotalM,DECarneM,DEViscerasM,DEConchaM),
  "D.Estandar Poblacional"=c(DETotalP,DECarneP,DEViscerasP,DEConchaP)
)
estadisticos
#Comparacion
#La muestra aleatoria obtenida a partir de la semilla utilizada es bastante fiel
#al total de los datos, puesto que los valores calculados para la media, mediana,
#varianza y desviacion estandar, son muy cercanos entre la muestra y la poblacion.
#Finalmente se puede decir que la muestra es representativa.

#Observacion: Todas las tildes fueron omitidas a proposito.
