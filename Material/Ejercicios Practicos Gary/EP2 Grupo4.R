# Ejercicio Practico N? 2
#
# Sala 4
#
# Integrantes: 
#
#             Ignacio Fern?ndez   19.687.744-4
#             Felipe Gonz?lez     19.360.650-4
#             Nicolas Salgado     19.848.869-0
#             Gary Simken         19.986.690-7
#             Ivan Zu?iga         20.003.345-0
#
#

library(ggplot2)
library(ggpubr)

# Indicar directorio
dir <- "C:/Users/Gary/Desktop/GITHUB/Pep1-IME-Grupo-6/Material"

# Una selecci?n de columnas (hecha por el profesor) de los resultados
# p?blicos de la encuesta Casen 2017 en la Regi?n Metropolitana.
# Las siguientes son las columnas que se eligieron:
#  - id.reg: n? secuencial del registro
#  - folio: identificador del hogar (comp: comuna ?rea seg viv hogar)
#  - o: n?mero de orden de la persona dentro del hogar
#  - id.vivienda: identificador de la vivienda (comp: comuna ?rea seg viv)
#  - hogar: identificaci?n del hogar en la vivienda
#  - region: regi?n
#  - provincia: provincia
#  - comuna: comuna
#  - ing.comuna: posici?n en el ranking hist?rico del ingreso de la
#                comuna (de menor a mayor ingreso)
#  - zona: ?rea geogr?fica (Urbano, Rural)
#  - sexo: sexo de la persona registrada
#  - edad: edad de la persona registrada
#  - ecivil: estado civil de la persona registrada
#  - ch1: situaci?n ocupacional de la persona registrada
#  - ytot: ingreso total

basename <- "Casen 2017.csv"
file <- file.path(dir, basename)

# Se agrega el contenido del CSV Casen 2017 a la variable poblacion
población <- read.csv(file = file, encoding = "UTF-8")

# Podemos obtener el n?mero de filas (o de columnas) que corresponde al n?mero de
# "casos" en la muestra/poblaci?n (o de variables).
tamaño.población <- nrow(población)

# Primero se elige una muestra de forma aleatoria, pero fijando una
# semilla para el generador de secuencias pseudoaleatorias para poder
# repetir los resultados

semilla <- 1234567890
tamaño.muestra <- 100

set.seed(semilla)
muestra <- población[sample(1:tamaño.población, tamaño.muestra), ]

# Pregunta d
#
# ?Tienen las personas que viven en ?reas rurales ingresos similares a quienes viven en ?reas urbanas?

# Se agrega ingreso a la variable muestra para observar mejor el gr?fico
# este divide el ingreso total en mil

muestra$ingreso <- muestra$ytot / 1000

población$ingreso <- población$ytot / 1000

# Se procede a graficar los datos de la muestra para comparar si los ingresos en ?reas rurales son similares a los 
# ingresos en ?reas urbanas, los datos fueron filtrados a 2 millones de pesos ya que los datos atipicos impedian 
# observar lo que estaba ocurriendo ya que estos eran muy grandes

grafico.muestra <- ggboxplot(
  muestra,
  x = "zona", y = "ingreso",
  ylim = c(0,2000),
  add = "mean", add.params = list(color = "#FC4E07"),
  color = "zona",
  title = "Ingreso totales en la muestra",
  ylab = "Ingreso total (miles de pesos)"
)
grafico.muestra

# como se puede observar, los ingresos no son similares ya que hay una tendencia a que los ingresos sean 
# mayores en zonas urbanas


# Se procede a graficar los datos de la poblaci?n para comparar si los ingresos en ?reas rurales son similares 
# a los ingresos en ?reas urbanas

grafico.poblacion <- ggboxplot(
  población,
  x = "zona", y = "ingreso",
  ylim = c(0,10000),
  add = "mean", add.params = list(color = "#FC4E07"),
  color = "zona",
  title = "Ingresos totales en la poblaci?n",
  ylab = "Ingreso total (miles de pesos)"
)
grafico.poblacion

# Debido a que los datos atipicos son muy grandes, se reducira el limite a graficar para observar el 
# grafico con menos datos atipicos

grafico.poblacion2 <- ggboxplot(
  población,
  x = "zona", y = "ingreso",
  ylim = c(0,2000),
  add = "mean", add.params = list(color = "#FC4E07"),
  color = "zona",
  title = "Ingresos totales en la poblaci?n",
  ylab = "Ingreso total (miles de pesos)"
)
grafico.poblacion2

# como se mostraba en la muestra, existe una clara diferencia entre los ingresos en el ?rea rural y urbano
# siendo este ?ltimo uno con mayor ingresos

# Pregunta g
#
# ?Tiene relaci?n el ingreso con la riqueza del municipio donde se habita?

#muestra
#se agrupa las comunas y se calcula el promedio de ingreso total por comuna
agrupacion_ytot<- setNames(
  aggregate(
    muestra[,14],
    list(muestra$comuna),
    mean),
  c("comuna","ytot")
)
#se agrupa las comunas y se calcula el ranking por comuna
agrupacion_ranking<- setNames(aggregate(muestra[,8],list(muestra$comuna),mean),c("comuna","ing.comuna"))
total_muestra<-setNames(merge(agrupacion_ranking,agrupacion_ytot,by="comuna"),c("comuna","ing.comuna","promedio_ytot"))


#poblacion 
#se agrupa las comunas y se calcula el promedio de ingreso total por comuna
agrupacion_ytot<- setNames(
  aggregate(
    población[,14],
    list(población$comuna),
    mean),
  c("comuna","ytot")
)
#se agrupa las comunas y se calcula el ranking por comuna
agrupacion_ranking<- setNames(aggregate(población[,8],list(población$comuna),mean),c("comuna","ing.comuna"))
total_poblacion<-setNames(merge(agrupacion_ranking,agrupacion_ytot,by="comuna"),c("comuna","ing.comuna","promedio_ytot"))

#Se grafican con un diagrama de dispersion de datos emparejados para la muestra y la poblacion
ggscatter(total_muestra,'ing.comuna','promedio_ytot',title='Ranking vs ingreso muestra',xlab='ranking',ylab='ingreso promedio comuna',add="reg.line")
ggscatter(total_poblacion,'ing.comuna','promedio_ytot',title='Ranking vs ingreso poblaci?n',xlab='ranking',ylab='ingreso promedio comuna',add="reg.line")

#Se puede apreciar en ambos gr?ficos que existe una mayor corelacion en ranking vs ingresos de la poblaci?n, que con los datos de la muestra
#Sin embargo ambos no son representativo, ya que existen demasiados datos at?picos y ahora se prodecer? a calcular el coeficiente de correlaci?n para comprobarlo

#Coeficiente de correlaci?n
cor_Muestra<-cor(total_muestra$ing.comuna,total_muestra$promedio_ytot,method = "pearson") #~0.33
cor_poblacion<-cor(total_poblacion$ing.comuna,total_poblacion$promedio_ytot,method = "pearson")#~0.63
cor_Muestra
cor_poblacion
#Como se puede comprobar no existe un comportamiento similar, ni en la muestra ni en la poblaci?n,Sin embaro como se mencionaba antes
#no existe una relaci?n entre el ingreso con la riqueza en el municipio donde se habita. 


